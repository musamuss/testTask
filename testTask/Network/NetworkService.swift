//
//  NetworkService.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation


class NetworkService {
    
// MARK: - построение запроса данных по  url
    
    func request(searchTerm: String,completion: @escaping (Data?, Error?) -> Void) {
           //let parameters = self.prepareParametrs(searchTerm: searchTerm)
           let url = self.url()
           var request = URLRequest(url:url)
           request.allHTTPHeaderFields = prepareHeaders()
           request.httpMethod = "post"
           request.httpBody =  searchTerm.data(using: .utf8)
           let task = createDataTask(from: request, comletion: completion)
           task.resume()
        print(url)
       }
    
    
 //MARK:- задание параметро и токена
private func prepareHeaders() -> [String: String]? {
    var headers = [String: String]()
    headers["token"] = "gZvju1B-J9-JsRjg6f"
    headers["Content-Type"] = "application/x-www-form-urlencoded"
    return headers
}
    
private func prepareParametrs(searchTerm: String?) -> [String:String]{
    var parameters = [String: String]()
    parameters["a"] = searchTerm
    return parameters
    }

    
    
// MARK: -- Создание URL
private func url() -> URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "bnet.i-partner.ru"
    components.path = "/testAPI/"
    //components.queryItems = params.map{ URLQueryItem(name: $0, value: $1)}
    return components.url!
    }
// MARK: -- Создание запроса
   private func createDataTask(from request: URLRequest, comletion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                comletion(data,error)
            }
        }
    }
    
}
