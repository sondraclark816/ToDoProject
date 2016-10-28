//
//  ToDoListStore.swift
//  ToDo-SondraClark
//
//  Created by Sondra Clark on 10/24/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit

class ToDoStore {
    static let shared = ToDoStore()
    
    fileprivate var items: [Items]!
    
    var selectedImage: UIImage?
    
    init() {
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath) {
            items = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [Items]
        } else {
            items = []
            items.append(Items(title: "Item Title", text: "Item Text", dueDate: "", category: 0))

            save ()
        }
        sort()
    }
    
    //MARK: - Public Functions
    func getItem(_ index: Int) -> Items {
        return items[index]
    }
    
    func addItem(_ item: Items){
        items.insert(item, at: 0)
    }
    
    func updateItem(_ item: Items, index: Int) {
        items[index] = item
    }
    
    func deleteItem(_ index: Int) {
        items.remove(at: index)
    }
    
    func getCount() -> Int {
        return items.count
    }
    
    
    func save() {
        NSKeyedArchiver.archiveRootObject(items, toFile: archiveFilePath())
    }
    
    func sort() {
        items.sort { (item1, item2) -> Bool in
            return item1.date.compare(item2.date) == .orderedDescending
        }
        
        
    }
    //MARK: Private Functions
    fileprivate func archiveFilePath() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        //Makes a path directly to the file in an array of strings
        let documentsDirectory = paths.first!
        let path = (documentsDirectory as NSString).appendingPathComponent("ToDoListStore.plist")
        return path
    }
    
    
    
}
