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
    }
    
    func configureUI() {
        view.backgroundColor = .orange
    }
    
    func fetchArticles() {

    }
}

