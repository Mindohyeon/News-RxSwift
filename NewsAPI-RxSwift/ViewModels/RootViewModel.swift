//
//  RootViewModel.swift
//  NewsAPI-RxSwift
//
//  Created by 민도현 on 2022/05/06.
//

import Foundation
import RxSwift

class RootViewModel {
    let title = "Create Dohyeon"
    
    private let articleService : ArticleServiceProtocol
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[Article]> {
        articleService.fetchNews()
    }
}
