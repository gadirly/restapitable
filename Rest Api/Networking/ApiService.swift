//
//  ApiService.swift
//  Rest Api
//
//  Created by Babek Gadirli on 12.11.21.
//

import Foundation

class ApiService {
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        let popularMoviesUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=c7f7d1dc5a6aa58fd2f3602748ad9c64&language=en-US&page=1"
        
        guard let url = URL(string: popularMoviesUrl) else {return}
        
        //Create URL Session - work on the backround
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Responses")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
                
            }catch let error {
                completion(.failure(error))
            }
            

            
        }
        dataTask?.resume()
    }
}
