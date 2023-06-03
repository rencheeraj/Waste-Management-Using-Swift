//
//  APIManager.swift
//  WasteManagement
//
//  Created by Rencheeraj Mohan on 02/06/23.
//

import Foundation

import Foundation

final class APIManager {
    static let shared = APIManager()
    
    public func getJsonResult(completion: @escaping (Result<Response, Error>) -> Void) {
        
        guard let url = URL(string:base_url) else{
            return
        }
//        var request = URLRequest(url: url)
        let request = NSMutableURLRequest(url: url as URL)
        let requestHeaders : [String:String] = [HeaderField.authentication.rawValue : BASIC_AUTH, HeaderField.content_type.rawValue : ContentType.json.rawValue, HeaderField.session.rawValue : SESSION_VALUE]
        request.allHTTPHeaderFields = requestHeaders
        let post = params
        let postData = post.data(using: String.Encoding.ascii, allowLossyConversion: true)!
        request.httpBody = postData
        request.httpMethod = HeaderField.post.rawValue
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response , error) in

            if let error = error{
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            guard let data = data else{
                completion(.failure(error!))
                return
            }
                
            do {
                let result  = try JSONDecoder().decode(Response.self, from: data)
//                let result = try? JSONSerialization.jsonObject(with: data)
                print(result)
                let response = result
                completion(.success(response ))
                    
                }
                catch {
                    completion(.failure(error))
                }
        } .resume()
        }
    }


