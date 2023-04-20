//
//  LikedViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 04.04.2023.
//

import UIKit

protocol LikedViewControllerDelegate {
    func setAuthorFilter(author: String)
}

class LikedViewController: UIViewController {
    private let mainView = LikedView()
    private lazy var resetItem = UIBarButtonItem(title: "Очистить фильтр", style: .done, target: self, action: #selector(resetFilter))
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.setPosts(posts: CoreDataService.shared.getPostEntities())
    }
    
    private func setupNavigationBar() {
        let searchItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(presentSearchViewController))
        navigationItem.leftBarButtonItem = searchItem
        navigationItem.rightBarButtonItem = resetItem
        resetItem.isEnabled = false
    }
    
    @objc private func presentSearchViewController() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc private func resetFilter() {
        mainView.setPosts(posts: CoreDataService.shared.getPostEntities())
        resetItem.isEnabled = false
    }
}

extension LikedViewController: LikedViewControllerDelegate {
    func setAuthorFilter(author: String) {
        mainView.setPosts(posts: CoreDataService.shared.getPostEntities(with: author))
        resetItem.isEnabled = true
    }
}
