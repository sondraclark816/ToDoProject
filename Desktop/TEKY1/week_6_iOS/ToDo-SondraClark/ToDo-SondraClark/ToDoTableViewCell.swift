//
//  ToDoTableViewCell.swift
//  ToDo-SondraClark
//
//  Created by Sondra Clark on 10/24/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
  
    @IBOutlet weak var ToDoTitleLabel: UILabel!
    @IBOutlet weak var ToDoDateLabel: UILabel!
    @IBOutlet weak var DueDateTimeLabel: UILabel!
    @IBOutlet weak var ToDoTextLabel: UILabel!
    
    weak var items: Items!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    func setupCell(_ items:Items) {
        self.items = items
        ToDoTitleLabel.text = items.title
        ToDoDateLabel.text = items.dateString
        DueDateTimeLabel.text = items.dueDate
        ToDoTextLabel.text = items.text
        
    }
 

}
