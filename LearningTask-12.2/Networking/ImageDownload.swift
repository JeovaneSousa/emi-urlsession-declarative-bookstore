//
//  ImageDownload.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import UIKit

class ImageDowload {
    
    var session: URLSession
    var cache: URLCache

    init(session: URLSession = .shared,
         cache: URLCache = .shared) {
        self.session = session
        self.cache = cache
    }

    func execute(for url: URL,
                 completeOn completionQueue: DispatchQueue = .main,
                 completionHandler: @escaping (UIImage?, Metadata?, Error?) -> Void) {
        let request = URLRequest(url: url)

        DispatchQueue.global(qos: .userInitiated).async {
                  
            if let cached = self.cache.cachedResponse(for: request), let image = UIImage(data: cached.data) {
                completionQueue.async {
                    completionHandler(
                        image,
                        Metadata(fromCache: true, response: nil),
                        nil
                    )
                }
                
                debugPrint("Cache hit for \(request.url!.absoluteURL)")
                return
            }

            debugPrint("Cache miss for \(request.url!.absoluteURL)")

            self.session.dataTask(with: request) { [weak self] data, response, error in
                if let error = error {
                    completionQueue.async {
                        completionHandler(nil, nil, Error.unableToRequest(error))
                    }
                    return
                }

                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    
                    completionQueue.async {
                        completionHandler(
                            nil,
                            Metadata(fromCache: false, response: response),
                            Error.failedToFetch
                        )
                    }
                    return
                }

                DispatchQueue.global().async {
                    let response = CachedURLResponse(response: response, data: data)

                    self?.cache.storeCachedResponse(response, for: request)
                    debugPrint("Cached response for \(request.url!.absoluteURL)")
                }

                guard let loadedImage = UIImage(data: data) else {
                    completionQueue.async {
                        completionHandler(
                            nil,
                            Metadata(fromCache: false, response: response),
                            Error.invalidData
                        )
                    }
                    return
                }

                completionQueue.async {
                    completionHandler(
                        loadedImage,
                        Metadata(fromCache: false, response: response),
                        nil
                    )
                }

            }.resume()
        }
    }
}

extension ImageDowload {
    struct Metadata {
        let fromCache: Bool
        let response: URLResponse?
    }
}

extension ImageDowload {
    enum Error: Swift.Error, LocalizedError {
        case unableToRequest(Swift.Error)
        case failedToFetch
        case invalidData
        
        var errorDescription: String? {
            switch self {
            case .unableToRequest(let error):
                return "Could not possible to perform the request. \(error.localizedDescription)"
            case .failedToFetch:
                return "Could not possible to download the image."
            case .invalidData:
                return "Could not possible to build image. Possible data corruption. Try again!"
            }
        }
    }
}

