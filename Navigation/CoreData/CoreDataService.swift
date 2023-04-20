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
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, ((error as NSError).userInfo)")
            }
        })
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    
    //Использую оптимизацию — NSManagedObjectContext
    private lazy var backgroundContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    private init() {}
    
    func getPostEntities(with author: String = "") -> [PostEntity] {
        do {
            let posts = try context.fetch(PostEntity.fetchRequest())
            if author.isEmpty {return posts}
            return posts.filter { postEntity in
                return postEntity.author?.lowercased().contains(author.lowercased()) ?? false
            }
        } catch {
            return []
        }
    }
    
    func save(post: Post) {
        if postAlreadyExsists(post) {return}
        
        backgroundContext.perform {
            let newPostEntity = PostEntity(context: self.backgroundContext)
            newPostEntity.author = post.author
            newPostEntity.descript = post.description
            newPostEntity.image = post.image
            newPostEntity.likes = Int64(post.likes)
            newPostEntity.views = Int64(post.views)
            
            do {
                try self.backgroundContext.save()
            } catch {
                print (error.localizedDescription)
            }
        }
    }
    
    func remove (_ postEntity: PostEntity) {
        context.delete(postEntity)
    }
    
    private func postAlreadyExsists(_ post: Post) -> Bool {
        let postEntity = getPostEntities().contains { postEntity in
            postEntity.author == post.author &&
            postEntity.descript == post.description &&
            postEntity.image == post.image &&
            postEntity.likes == Int64(post.likes) &&
            postEntity.views == Int64(post.views)
        }
        return postEntity
    }
}
