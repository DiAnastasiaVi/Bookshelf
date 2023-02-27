//
//  BookScreenViewModel.swift
//  Bookshelf
//
//  Created by Anastasia on 12.02.2023.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class BookScreenViewModel {
    
    //MARK: -
    //MARK: Properties
    
    var cover = BehaviorRelay<UIImageView>(value: UIImageView())
    var disposeBag: DisposeBag = .init()
    var book: BookFound
    var bookManager: BookManager {
        return resolve(BookManager.self)
    }
    var coverImage = BehaviorRelay<UIImage?>(value: nil)
    
    init(book: BookFound) {
        self.book = book
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + "\(book.coverId)" + ".jpg"),
              let img = UIImage(named: "loading")
        else { return }
        
        self.cover.value.af.setImage(withURL: url,
//                                     placeholderImage: UIImage(named: "loading"),
                                     imageTransition: .crossDissolve(5.0))
        
//        self.cover.asObservable().map{$0.image}.bind(to: self.img).disposed(by: disposeBag)
        
        self.coverImage.accept(self.cover.value.image)
        
//        self.cover.asObservable().map{$0.image}.bind(onNext: { val in
//            if let image = val {
//                self.coverImage.accept(image)
//            } else {
//                self.coverImage.accept(img)
//            }
//        }).disposed(by: disposeBag)
        
        bookManager.failureMessage
            .asObservable()
            .bind(onNext: { message in
                if let message = message {
                    resolve(Router.self).showError(err: message, show: true)
                }
            }).disposed(by: disposeBag)
    }
}
