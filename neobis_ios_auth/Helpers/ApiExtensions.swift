//  Extensions.swift
//  neobis_ios_auth
//  Created by Askar Soronbekov

import Foundation

extension APIService {
    private func createRequest(forURL url: URL, withMethod method: String, parameters: [String: Any]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            fatalError("Failed to serialize JSON data: \(error)")
        }
        
        return request
    }
    
    private func performRequest(with request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
