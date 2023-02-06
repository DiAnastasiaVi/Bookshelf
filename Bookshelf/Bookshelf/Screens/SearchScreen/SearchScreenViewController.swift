//
//  SearchScreenViewController.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit
import RxSwift

class SearchScreenViewController: UIViewController, StoryboardLoadable {
    
    //MARK: -
    //MARK: Properties
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    public var viewModel: SearchScreenViewModel!
    internal var mainView: SearchScreenView {
        guard let mainView = self.view as? SearchScreenView else {fatalError("View Error")}
        return mainView
    }
    private var disposeBag: DisposeBag = .init()
    
    //MARK: -
    //MARK: Init and Deinit
    
    public static func startVC(viewModel: SearchScreenViewModel) -> SearchScreenViewController {
        let contr = self.loadFromStoryboard(storyboardName: "SearchScreen")
        contr.viewModel = viewModel
        return contr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        addBindsToViewModel()
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
    
    private func addBindsToViewModel() {
        searchBar?.rx.text
            .orEmpty
            .bind(onNext: { smthn in
                self.viewModel.searchTextObservable.accept(smthn)
                print(smthn)
                print(self.viewModel.searchTextObservable.value)
            }).disposed(by: disposeBag)
        
    }
}
    
