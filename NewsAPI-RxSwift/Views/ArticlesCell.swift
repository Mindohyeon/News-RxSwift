//
//  ArticlesCell.swift
//  NewsAPI-RxSwift
//
//  Created by 민도현 on 2022/05/07.
//
import UIKit
import RxSwift
import SDWebImage

class ArticlesCell: UICollectionViewCell {
    
    //PublishSubject 는 데이터를 전달받아서 subscriber 들에게 뿌려주는 역할을 한다.
    var viewModel = PublishSubject<ArticleViewModel>()
    let disposeBag = DisposeBag()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iv.backgroundColor = .secondarySystemBackground
        
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subscribe() {
        self.viewModel.subscribe(onNext: { articleViewModel in
            if let urlString = articleViewModel.imageUrl {
                self.imageView.sd_setImage(with: URL(string: urlString), completed: nil)
            }
            
            self.titleLabel.text = articleViewModel.title
            self.descriptionLabel.text = articleViewModel.description
        }).disposed(by: disposeBag)
    }
    
    func configureUI() {
        backgroundColor = .systemBackground
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 40).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    }
    
}
