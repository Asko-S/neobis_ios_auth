// APIService.swift
// neobis_ios_auth
// Created by Askar Soronbekov

import Foundation

class APIService {
    let baseURL = "http://64.227.66.224/"
    
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
    
    func post(endpoint: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        let request = createRequest(forURL: url, withMethod: "POST", parameters: parameters)
        performRequest(with: request, completion: completion)
    }
    
    func put(endpoint: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        let request = createRequest(forURL: url, withMethod: "PUT", parameters: parameters)
        performRequest(with: request, completion: completion)
    }
    
    func patch(endpoint: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        let request = createRequest(forURL: url, withMethod: "PATCH", parameters: parameters)
        performRequest(with: request, completion: completion)
    }
}
