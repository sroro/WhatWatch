//
//  CoreDataManager.swift
//  WhatWatch
//
//  Created by Rodolphe Schnetzer on 11/10/2022.
//

import Foundation
import CoreData


final class CoreDataManager {
    
    //MARK: - properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var medias: [InfoMedia] {
        let request: NSFetchRequest<InfoMedia> = InfoMedia.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "review", ascending: true)]
        guard let media = try? managedObjectContext.fetch(request) else { return []}
        return media
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    //MARK: - Managed InfoMedia Entity
    
    func createMedia(title:String, id:Double, review:Double, image: URL, overview:String, date:String) {
        let infoMedia = InfoMedia(context: managedObjectContext)
        
        infoMedia.title = title
        infoMedia.id = id
        infoMedia.review = review
        infoMedia.image = image
        infoMedia.overview = overview
        infoMedia.date = date
        
        coreDataStack.saveContext()
    }
    
    func deleteAllMedia() {
        medias.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
        }
    
    func isRegistered(title:String) -> Bool {
        let request: NSFetchRequest<InfoMedia> = InfoMedia.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        guard let infos = try? managedObjectContext.fetch(request) else {
            return false
        }
        if infos.isEmpty {
            return false
        }
        return true
    }
    
    func deleteMedia(title:String){
        let request: NSFetchRequest<InfoMedia> = InfoMedia.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        guard let infos = try? managedObjectContext.fetch(request) else { return }
        guard let info = infos.first else { return }
        managedObjectContext.delete(info)
        coreDataStack.saveContext()
    }
    
    }

