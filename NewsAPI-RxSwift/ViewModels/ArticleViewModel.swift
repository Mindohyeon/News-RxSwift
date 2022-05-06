//
//  ArticleViewModel.swift
//  NewsAPI-RxSwift
//
//  Created by 민도현 on 2022/05/06.
//

import Foundation

class ArticleViewModel {
    private let article: Article
    
    var imageUrl: String? {
        return article.urlToImage
    }
    
    var title: String? {
        return article.title
    }
    
    var description: String? {
        return article.description
    }
    
    
    init(article: Article) {
        self.article = article
    }
}
