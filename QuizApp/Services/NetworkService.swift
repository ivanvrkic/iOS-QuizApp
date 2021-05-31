//
//  NetworkService.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 14.05.2021..
//

import Foundation

class NetworkService : NetworkServiceProtocol {
    private let hostUrl: String = "https://iosquiz.herokuapp.com/api"
    
    func login(username: String, password: String, completionHandler: @escaping (LoginStatus) -> Void) {
        guard let url = URL(string: "\(hostUrl)/session?username=\(username)&password=\(password)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        executeUrlRequest(request) { (result: Result<LoginResponseData, RequestError>) in
            switch result {
            case .failure(_):
                completionHandler(.error(400, "Bad Request"))
            case .success(let value):
                let defaults = UserDefaults.standard
                defaults.setValue(value.userId, forKey: "userId")
                defaults.setValue(value.token, forKey: "token")
                completionHandler(.success)
            }
        }
    }
    
    func fetchQuizzes(token: String, completionHandler: @escaping ([Quiz]) -> Void) {
        guard let url = URL(string: "\(hostUrl)/quizzes") else { return }
        
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        executeUrlRequest(request) { (result: Result<QuizzesResponseData, RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let value):
                completionHandler(value.quizzes)
            }
        }
    }
    
    func sendResult(token: String, quizResult: QuizResult) {
        guard let url = URL(string: "\(hostUrl)/result") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")

        request.httpBody = try! JSONEncoder().encode(quizResult)

        executeUrlRequest(request) { (result: Result<String, RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let value):
                print(value)
            }
        }
    }
      
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping
(Result<T, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noDataError))
                }
                return
            }
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.decodingError))
                }
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(.success(value))
            }
            
        }
        
        dataTask.resume()
    }
    
}
