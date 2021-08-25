//
//  Networking.swift
//  Networking
//
//  Created by Lee on 8/5/21.
//

import Foundation


enum NetworkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case unableToEncode
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL."
        case .thrownError(let error):
            return "Opps, there was an error: \(error.localizedDescription) -- \(#function) -- \(#file) -- \(#line)"
        case .noData:
            return "The server failed to load any data. -- \(#function) -- \(#file) -- \(#line)"
        case .unableToDecode:
            return "There was an error when trying to load the data from the server. -- \(#function) -- \(#file) -- \(#line)"
        case .unableToEncode:
            return "There was an error when trying to save the data to the server. -- \(#function) -- \(#file) -- \(#line)"
        }
    }
}

class NetworkServicing {
    
    static let shared = NetworkServicing()
    
    func fetch<T: Decodable>(endpoint: URL?, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = endpoint else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("=================== Response :\(response.statusCode)====================== at \(#line) \(#function)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            print(String(data: data, encoding: .utf8)!)
            do {
                let nReturnVal = try JSONDecoder().decode(T.self, from: data)
                print()
                completion(.success(nReturnVal))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    func save<T: Codable>(endpoint: URL?, type: T, completion: @escaping (Result<T, NetworkError>) -> Void)  {
        guard let url = endpoint else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonBody = try JSONEncoder().encode(type)
            request.httpBody = jsonBody
            print("=================== Encode ======================\(#line) \(#function)")
            print(String(data: jsonBody, encoding: .utf8)!)
        } catch {
            completion(.failure(.unableToEncode))
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse{
                print("=================== Response :\(response.statusCode)====================== at \(#line) \(#function)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let nReturnVal = try JSONDecoder().decode(T.self, from: data)
                print("=================== Decode ======================\(#line) \(#function)")
                print(String(data: data, encoding: .utf8)!)
                completion(.success(nReturnVal))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
