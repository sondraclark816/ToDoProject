//
//  ToDoItems.swift
//  ToDo-SondraClark
//
//  Created by Sondra Clark on 10/24/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import Foundation
import UIKit

class Items: NSObject, NSCoding {
    var title = ""
    var text = ""
    var date = Date()
    var image: UIImage?
    var category = 0
    var dueDate = ""
    
    
    let titleKey = "title"
    let textKey = "text"
    let dateKey = "date"
    let imageKey = "image"
    let dueDateKey = "MM-dd-yyyy HH:mm"
    let categoryKey = "category"
   
    
    var dateString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
    
    override init() {
        super.init()
        
    }
    
    init(title: String, text: String, dueDate: String, category: Int) {
        self.title = title
        self.text = text
        self.dueDate = dueDate
        self.category = category
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: titleKey) as! String
        self.text = aDecoder.decodeObject(forKey: textKey) as! String
        self.date = aDecoder.decodeObject(forKey: dateKey) as! Date
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
        self.dueDate = aDecoder.decodeObject(forKey: dueDateKey) as! String
        self.category = aDecoder.decodeInteger(forKey: categoryKey)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(text, forKey: textKey)
        aCoder.encode(date, forKey: dateKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(dueDate, forKey: dueDateKey)
        aCoder.encode(category, forKey: categoryKey)
        
    }
}
