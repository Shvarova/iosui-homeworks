//
//  CoreDataService.swift
//  Navigation
//
//  Created by Дина Шварова on 04.04.2023.
//

import UIKit
import CoreData
import StorageService

final class CoreDataService {
    
    static let shared = CoreDataService()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var postEntities: [PostEntity] {
        get {
            do {
                let posts = try context.fetch(PostEntity.fetchRequest())
                return posts
            } catch {
                return []
            }
        }
    }
    
    private init() {}
    
    func save(post: Post) {
        if postAlreadyExsists(post) {return}
        
        let newPostEntity = PostEntity(context: context)
        newPostEntity.author = post.author
        newPostEntity.descript = post.description
        newPostEntity.image = post.image
        newPostEntity.likes = Int64(post.likes)
        newPostEntity.views = Int64(post.views)
        
        do {
            try context.save()
        } catch {
            print (error.localizedDescription)
        }
    }
    
    private func postAlreadyExsists(_ post: Post) -> Bool {
        let postEntity = postEntities.contains { postEntity in
            postEntity.author == post.author &&
            postEntity.descript == post.description &&
            postEntity.image == post.image &&
            postEntity.likes == Int64(post.likes) &&
            postEntity.views == Int64(post.views)
        }
        return postEntity
    }
}
