//
//  StorageManager.swift
//  TaskList
//
//  Created by Vasiliy on 24.08.2022.
//

import UIKit
import CoreData

class StorageManager {
    static let shared = StorageManager()


    var taskListManger: [Task] = []
    lazy var viewContext = self.persistentContainer.viewContext

    private init() {}

    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchData() {
        let fetchRequest = Task.fetchRequest()

        do {
            taskListManger = try viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteRow(at index: Int) {
        var tasks = taskListManger
        tasks.remove(at: index)
    }

    func update(_ task: Task, newName: Task) {
        _ = newName
    }
}
