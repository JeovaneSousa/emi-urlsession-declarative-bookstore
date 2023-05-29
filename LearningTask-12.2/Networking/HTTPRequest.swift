//
//  HTTPMethod.swift
//  LearningTask-12.2
//
//  Created by jeovane.barbosa on 10/01/23.
//

import Foundation
extension HTTPURLResponse {
    var inSucessRange: Bool {
        return statusCode >= 200 && statusCode < 300
    }
}

enum HTTPMethod: String {
    case GET, POST, DELETE, PUT
    
}

extension Result {
    init(value: Success?, error: Failure?) {
        if let error = error {
            self = .failure(error)
            return
        }

        if let value = value {
            self = .success(value)
            return
        }
        fatalError("Unable to create result")
    }
}

typealias HTTPHeaders = [String: String]
typealias DataTaskResult = Result<Data, Error>
typealias HTTPResult<T> = Result<T, NetworkError>

class HTTPRequest {
    
    let urlTemplate: String = "https://casadocodigo-api.herokuapp.com/api%@"
    
    let session: URLSession
    var dataTask: URLSessionDataTask?
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func execute<T: Codable>(for resource: String,
                             httpMethod: HTTPMethod = .GET,
                             codable: Codable? = nil,
                             httpHeaders: HTTPHeaders? = nil,
                             encoder: JSONEncoder = .init(),
                             decoder: JSONDecoder = .init(),
                             completionHandler: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        //Build url
        let urlString = String.init(format: urlTemplate, resource)
        
        guard let url = URL(string: urlString) else {
            preconditionFailure("Unable to create URL")
        }
        
        //Build and set request
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let headers = httpHeaders {
            headers.forEach {(key, value) in request.setValue(value, forHTTPHeaderField: key)}
        }
        
        if let codable = codable {
            do {
                let data = try encoder.encode(codable)
                
                request.httpBody = data
                request.setValue("application/json", forHTTPHeaderField: "Content-type")
                
            } catch {
                let contextError = NetworkError.unableToPerformRequest(error)
                
                completionHandler(.failure(contextError))
                return
            }
        }
        
        dataTask?.cancel()
        dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            
            let dataTaskResult = DataTaskResult(value: data, error: error)
            
            defer {
                self?.dataTask = nil
            }
            
            switch dataTaskResult {
                
            case .failure(let error):
                completionHandler(.failure(.unableToPerformRequest(error)))
                return
                
            case .success(let data):
                let result: HTTPResult = Result {try decoder.decode(T.self, from: data)}
                    .flatMapError { error in
                        if let response = response as? HTTPURLResponse, !response.inSucessRange {return .failure(.requestFailed(response.statusCode))}
                        return .failure(.invalidData(error))
                    }
                
                completionHandler(result)
                return
            }
        }
        dataTask?.resume()
    }
}

enum NetworkError: Error, LocalizedError {
    case unableToPerformRequest(Error)
    case requestFailed(Int)
    case invalidData(Error)
    
    var description: String? {
        switch self {
            
        case .unableToPerformRequest(let error):
            return "Unable to perform request: \(error.localizedDescription)"
            
        case .requestFailed(let statusCode):
            return "Request failed. Response status code: \(statusCode)"
            
        case .invalidData(let error):
            return "Unable to parse data. Reason: \(error.localizedDescription)"
        }
    }
}


