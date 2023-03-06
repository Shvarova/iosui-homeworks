//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Дина Шварова on 14.02.2023.
//

import UIKit
import StorageService

protocol ProfileViewModelProtocol {
    
    var updateView: ((ProfileModel) -> ())? { get set }
    func startUpdate()
}

enum PostsError: Error {
    case postsNotFound
}

class ProfileViewModel: ProfileViewModelProtocol {
    var updateView: ((ProfileModel) -> ())?
    
#if DEBUG
    private let service = TestUserService()
#else
    private let service = CurrentUserService()
#endif
    
    func startUpdate() {
        let result = getPosts()
        switch result {
        case .success(let posts) : updateView?(ProfileModel(user: getUser(), posts: posts))
        case .failure(let error) : print (error)
        }
    }
    
    private func getUser() -> User {
        return service.getUser()
    }
    
    private func getPosts() -> Result <[Post], PostsError> {
        return .success([
            Post(author: "Любовники моей жены", description: "Картина австрийского художника Карла Калера. Её заказал американский миллионер Кейт Бердсал Джонсон, который содержал 350 питомцев жены.", image: "Cats", likes: 32, views: 55),
            Post (author: "Луис Уэйн – Мальчишник", description: "Художник прославился своими антропоморфными изображениями кошек. По словам английского писателя Герберта Уэллса, Луис придумал не только свой собственный кошачий стиль, а и создал самое настоящее кошачье общество и кошачий мир.", image: "Gents", likes: 251, views: 573),
            Post (author: "Белый кот. Пьер Боннар.", description: "Боннар воспользовался новым приемом деформации, стремясь воссоздать юмористический образ этого животного, занявшего весьма причудливую позу.", image: "Cat", likes: 344, views: 692),
            Post (author: "Теофиль Александр Стейлен", description: "Рисунки котов для рекламы кабаре, которое в свою золотую эпоху было местом встречи творческой элиты.", image: "Poster", likes: 377, views: 518),
            Post (author: "Пьер Огюст Ренуар – Жюли Мане (Девочка с кошкой)", description: "Берта Моризо и её муж Эжен Мане, брат легендарного творца, знали Ренуара и заказали у него портрет своей дочери", image: "Kitty", likes: 684, views: 984)])
    }
}
