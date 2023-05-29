//
//  LivrosAPI.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

class LivrosAPI {
    
    let httpRequest: HTTPRequest
    let userAuthentication: UserAuthentication
    
    init(httpRequest: HTTPRequest = .init(),
         userAuthentication: UserAuthentication = .init()) {
        self.httpRequest = httpRequest
        self.userAuthentication = userAuthentication
    }
    
    func carregaTodos(completionHandler: @escaping (LivrosAPI.Result<[Livro]>) -> Void,
                      completionQueue: DispatchQueue = .main) {
        
        guard let authentication = userAuthentication.get() else {
            preconditionFailure("User must be logged in.")
        }
        
        let headers = ["Authorization" : authentication.value]
        
        
        httpRequest.execute(for: "/book",
                         httpHeaders: headers) { (result: HTTPResult<[Livro]>) in
            switch result {
                
            case .success(let livros):
                completionQueue.async {
                    completionHandler(.success(livros))
                }
                
                
            case .failure(let error):
                completionQueue.async {
                    completionHandler(.failure(.unableToExecute(error)))
                }
            }
        }
        
    }
    
    func carregaLivros(porAutorId id: Int,
                    completionHandler: @escaping (LivrosAPI.Result<[Livro]>) -> Void,
                    completionhQueue: DispatchQueue = .main) {

        guard let authentication = userAuthentication.get() else {
            preconditionFailure("User must be logged in.")
        }
        
        let headers = ["Authorization" : authentication.value]
        
        httpRequest.execute(for: "/author/\(id)/books",
                         httpHeaders: headers) { (result: HTTPResult<[Livro]>) in
            
            switch result {
                
            case .success(let livros):
                completionhQueue.async {
                    completionHandler(.success(livros))
                }

                
            case .failure(let error):
                completionhQueue.async {
                    completionHandler(.failure(.unableToExecute(error)))
                }
            }

        }
    }
    
    func registraNovo(livro: BookInput,
                      completionHandler: @escaping (LivrosAPI.Result<Livro>) -> Void,
                      completionQueue: DispatchQueue = .main) {

        guard let authentication = userAuthentication.get() else {
            preconditionFailure("User must be logged in.")
        }
        
        let headers = ["Authorization": authentication.value]

        httpRequest.execute(for: "/book",
                            httpMethod: .POST,
                            codable: livro,
                            httpHeaders: headers) { (result: HTTPResult<Livro>) in
            
            switch result {
                
            case .success(let livro):
                completionQueue.async {
                    completionHandler(.success(livro))
                }
                
            case .failure(let error):
                completionQueue.async {
                    completionHandler(.failure(.unableToExecute(error)))
                }
            }
        }
    }
}



extension LivrosAPI {
    typealias Result<success> = Swift.Result<success, ApiError>
    
    enum ApiError: Error, LocalizedError {
        
        case unableToExecute(NetworkError)
        
        var description: String? {
            switch self {
            case .unableToExecute(let error):
                return error.description
                
            }
        }
    }
}

