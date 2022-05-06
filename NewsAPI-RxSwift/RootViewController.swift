//
//  ViewController.swift
//  NewsAPI-RxSwift
//
//  Created by 민도현 on 2022/05/05.
//

import UIKit
import RxSwift
import RxRelay

class RootViewController: UIViewController {
    
    let viewModel: RootViewModel
    let disposeBag = DisposeBag()
    
    private var articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchArticles()
        subscribe()
    }
    
    func configureUI() {
        view.backgroundColor = .orange
    }
    
    func fetchArticles() {
        viewModel.fetchArticles().subscribe(onNext: { articleViewModels in
            self.articleViewModel.accept(articleViewModels)
        }).disposed(by: disposeBag)
    }
    
    func subscribe() {
        articleViewModel.subscribe(onNext: { articles in
            print(articles)
        }).disposed(by: disposeBag)
    }
}

