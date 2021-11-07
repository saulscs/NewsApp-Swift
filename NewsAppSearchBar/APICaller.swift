//
//  APICaller.swift
//  NewsAppSearchBar
//
//  Created by saul corona on 05/11/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constanst {
        static let topHeadLines = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=")
    }
    
    private init (){}
    
    public func getTopStories(completion:  @escaping(Result<[Article], Error>) -> Void) {
        guard let url = Constanst.topHeadLines else {
        return
    }
        let task = URLSession.shared.dataTask(with: url){
            data, _, error in if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                    print(result.articles)
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


// Models

struct APIResponse: Codable{
    let articles: [Article]
}

struct Article: Codable{
    let source: Source
    let title: String
    let subtitle: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
