//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 26.09.2022.
//

import UIKit
import StorageService
import FirebaseAuth

protocol ProfileOutput {
    func photosCellSelected()
    func signOutButtonTouched()
}

final class ProfileViewController: UIViewController {
    
    var output: ProfileOutput?
    
    private var viewModel: ProfileViewModelProtocol?
    private var posts: [Post]?
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView ()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView ()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    
    func setViewModel(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        updateView()
    }
    
    private func updateView() {
        viewModel?.updateView = { [weak self] model in
            self?.posts = model.posts
            self?.profileHeaderView.addInfoUser(user: model.user)
        }
        viewModel?.startUpdate()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Профиль"
        let signOut = UIBarButtonItem(title: "sign out", style: .done, target: self, action: #selector(signOut))
        navigationItem.leftBarButtonItem = signOut
    }
    
    @objc func signOut() {
        try? Auth.auth().signOut()
        output?.signOutButtonTouched()
    }
    
    private func setupView() {
        
#if DEBUG
        view.backgroundColor = .systemMint
#else
        view.backgroundColor = .white
#endif
        view.addSubviews([profileHeaderView, tableView])
        
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            output?.photosCellSelected()
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = posts else { return 0 }
        return posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell
            return cell ?? defaultCell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell,
              let posts = posts else { return defaultCell }
        let row = indexPath.row - 1
        cell.doubleTapAction = {
            CoreDataService.shared.save(post: posts[row])
        }
        cell.selectionStyle = .none
        cell.authorLabel.text = posts[row].author
        cell.setupImage(name: posts[row].image)
        cell.descriptionLabel.text = posts[row].description
        cell.likesLabel.text = "Likes: \(posts[row].likes)"
        cell.viewsLabel.text = "Views: \(posts[row].views)"
        return cell
    }
}


