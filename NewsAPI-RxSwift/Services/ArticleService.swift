//
//  ArticleService.swift
//  NewsAPI-RxSwift
//
//  Created by 민도현 on 2022/05/05.
//

import Foundation
import Alamofire

class ArticleService {
    private func fetchNews(completion:@escaping((Error?, [Article]?) -> Void)) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2022-04-05&sortBy=publishedAt&apiKey=593c937d5e9f4e1e9193f751d7f40c59"
        
        guard let url = URL(string: urlString) else { return completion(NSError(domain: "dohyeon113", code: 404, userInfo: nil), nil)}
        
        let request = AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
            .responseDecodable(of: ArticleResponse.self) { response in
                if let error = response.error {
                    return completion(error, nil)
                }
                
                if let articles = response.value?.articles {
                    return completion(nil, articles)
                }
            }
    }
}
