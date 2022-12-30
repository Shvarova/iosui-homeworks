//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дина Шварова on 26.09.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var posts = [Post (author: "Любовники моей жены", description: "Картина австрийского художника Карла Калера. Её заказал американский миллионер Кейт Бердсал Джонсон, который содержал 350 питомцев жены.", image: "Cats", likes: 32, views: 55),
                         Post (author: "Луис Уэйн – Мальчишник", description: "Художник прославился своими антропоморфными изображениями кошек. По словам английского писателя Герберта Уэллса, Луис придумал не только свой собственный кошачий стиль, а и создал самое настоящее кошачье общество и кошачий мир.", image: "Gents", likes: 251, views: 573),
                         Post (author: "Белый кот. Пьер Боннар.", description: "Боннар воспользовался новым приемом деформации, стремясь воссоздать юмористический образ этого животного, занявшего весьма причудливую позу.", image: "Cat", likes: 344, views: 692),
                         Post (author: "Теофиль Александр Стейлен", description: "Рисунки котов для рекламы кабаре, которое в свою золотую эпоху было местом встречи творческой элиты.", image: "Poster", likes: 377, views: 518),
                         Post (author: "Пьер Огюст Ренуар – Жюли Мане (Девочка с кошкой)", description: "Берта Моризо и её муж Эжен Мане, брат легендарного творца, знали Ренуара и заказали у него портрет своей дочери", image: "Kitty", likes: 684, views: 984)]
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Профиль"
    }

    private func setupView() {
        view.backgroundColor = .white
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
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.authorLabel.text = posts[indexPath.row].author
        cell.setupImage(name: posts[indexPath.row].image)
        cell.descriptionLabel.text = posts[indexPath.row].description
        cell.likesLabel.text = "Likes: \(posts[indexPath.row].likes)"
        cell.viewsLabel.text = "Views: \(posts[indexPath.row].views)"
        return cell
    }
}
