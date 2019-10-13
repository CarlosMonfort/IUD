//
//  APIClient.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

class APIClient: NSObject, URLSessionDelegate {
    
    static let shared = APIClient()
    
    typealias APICompletion = (Result<Data?, APIError>) -> Void
    
    let URLService = "https://hello-world.innocv.com/api/User"
    var session: URLSession?
    
    override init() {
        super.init()
        session = URLSession(configuration: .default)
    }
    
    /**Realiza la petición a la API*/
    func performGetRequest(_ request: APIRequest, _ completion: @escaping APICompletion) {
        let urlString = URLService + request.path
        guard let baseURL = URL(string: urlString) else { completion(.failure(.invalidURL)); return }
        guard let session = self.session else { completion(.failure(.sessionFail)); return }
        
        let task = session.dataTask(with: baseURL) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { completion(.failure(.requestFailed)); return }
            guard let data = data else { completion(.failure(.noData)); return }
            completion(.success(data))
        }
        task.resume()
    }
    
    /**Realiza la petición a la API*/
    func performRequest(_ request: APIRequest, _ completion: @escaping APICompletion) {
        let urlString = URLService + request.path
        guard let baseURL = URL(string: urlString) else { completion(.failure(.invalidURL)); return }
        guard let session = self.session else { completion(.failure(.sessionFail)); return }
        
        /*var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path
        urlComponents.queryItems = request.queryItems
        
        let url = baseURL.appendingPathComponent(request.path.self)*/
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody  = request.body
        
        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { completion(.failure(.requestFailed)); return }
            print(httpResponse.statusCode)
            completion(.success(data))
        }
        task.resume()
    }
}
