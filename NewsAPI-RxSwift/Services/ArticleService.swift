//
//  ArticleService.swift
//  NewsAPI-RxSwift
//
//  Created by 민도현 on 2022/05/05.
//

import Foundation
import Alamofire
import RxSwift


protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
}

class ArticleService: ArticleServiceProtocol {
    
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            
            self.fetchNews { error, articles in
                if let error = error {
                    //onError - 오류가 있음을 알리고 중간에서 종류시킬 수 있는 기능, observable 구독자에게 오류 알림
                    observer.onError(error)
                }
                
                if let articles = articles {
                    //onNext - 구성요소를 계속 방출시킬 수 있는 기능, observable 구독자에게 데이터 전달
                    observer.onNext(articles)
                }
                
                //onCompleted - 이벤트를 종료시킬 수 있는 기능, observable 구독자에게 완료되었음을 알림
                observer.onCompleted()
            }
            
            //Disposables - observer 가 필요 없어졌을 때 메모리의 할당을 지워줌
            return Disposables.create()
        }
    }
    
    private func fetchNews(completion:@escaping((Error?, [Article]?) -> Void)) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2022-04-07&sortBy=publishedAt&apiKey=593c937d5e9f4e1e9193f751d7f40c59"
        
        guard let url = URL(string: urlString) else { return completion(NSError(domain: "dohyeon113", code: 404, userInfo: nil), nil)}
        
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
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
