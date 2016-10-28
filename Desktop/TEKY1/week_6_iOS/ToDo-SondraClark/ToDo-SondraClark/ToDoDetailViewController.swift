//
//  ToDoDetailViewController.swift
//  ToDo-SondraClark
//
//  Created by Sondra Clark on 10/24/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit

class ToDoDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var ToDoTitleField: UITextField!
    @IBOutlet weak var ToDoTextView: UITextView!
    @IBOutlet weak var ToDoImageView: UIImageView!
    
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var CategoryPicker: UIPickerView!
    
    @IBOutlet weak var DueDateLabel: UILabel!
    @IBOutlet weak var DueDatePicker: UIDatePicker!
    
    var CategoryPickerData: [String] = [String]()
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    var listItem = Items()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CategoryPicker.delegate = self
        self.CategoryPicker.dataSource = self
        
        CategoryPickerData = ["Uncategorized","Home", "Work", "Personal"]
        ToDoTitleField.text = listItem.title
        ToDoTextView.text = listItem.text
        
        if let image = listItem.image {
            ToDoImageView.image = image
            addGestureRecognizer()
        } else {
            ToDoImageView.isHidden = true
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        return CategoryPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CategoryPickerData[row]
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoStore.shared.getCount()
    }
    
    func addGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
        ToDoImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func viewImage() {
        if let image = ToDoImageView.image {
            ToDoStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageNavController")
            present(viewController, animated: true, completion: nil)
            
        }
        
    }
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion:  nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        listItem.title = ToDoTitleField.text!
        listItem.text = ToDoTextView.text
        listItem.date = Date()
        listItem.image = ToDoImageView.image
        listItem.dueDate = DueDateLabel.text!
        listItem.category = CategoryPicker.selectedRow(inComponent: 0)
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    //MARK: IBActions
    
    @IBAction func DatePicker(_ sender: AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let strDate = dateFormatter.string(from: DueDatePicker.date)
        self.DueDateLabel.text = strDate
        
    }
    
    
    @IBAction func choosePhoto(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Picture", message: "Choose a picture type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in  self.showPicker(.camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in  self.showPicker(.photoLibrary)
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension ToDoDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            let maxSize: CGFloat = 512
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: maxSize, height: newHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            ToDoImageView.image = resizedImage
            
            ToDoImageView.isHidden = false
            if gestureRecognizer != nil {
                ToDoImageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
            
        }
    }
}


