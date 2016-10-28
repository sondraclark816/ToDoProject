//
//  ImageViewController.swift
//  ToDo-SondraClark
//
//  Created by Sondra Clark on 10/26/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit
class ImageViewController: UIViewController {
    
    @IBOutlet weak var ToDoImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = ToDoStore.shared.selectedImage {
            ToDoImageView.image = image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: AnyObject) {
        ToDoStore.shared.selectedImage = nil
        dismiss(animated: true, completion: nil)
        
    }
    
}
