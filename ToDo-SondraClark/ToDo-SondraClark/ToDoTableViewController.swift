//
//  ToDoTableViewController.swift
//  ToDo-SondraClark
//
//  Created by Sondra Clark on 10/24/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //         Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ToDoStore.shared.getCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ToDoTableViewCell.self)) as! ToDoTableViewCell
        
        // Configure the cell...
        cell.setupCell(ToDoStore.shared.getItem(indexPath.row))
        cell.setupCell(ToDoStore.shared.getToDoItem(indexPath.row, category: indexPath.section))
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ToDoStore.shared.deleteItem(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItemSegue" {
            let ToDoDetailVC = segue.destination as! ToDoDetailViewController
            let tableCell = sender as! ToDoTableViewCell
            ToDoDetailVC.listItem = tableCell.items
        }
    }
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    
    
    //MARK: - Unwind Segue
    @IBAction func saveItemDetail(_ segue: UIStoryboardSegue) {
        let ToDoDetailVC = segue.source as! ToDoDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            ToDoStore.shared.updateItem(ToDoDetailVC.listItem, index: indexPath.row)
            ToDoStore.shared.sort()
            
            var indexPaths: [IndexPath] = []
            for index in 0...indexPath.row{
                indexPaths.append(IndexPath(row: index, section: 0 ))
            }
            
            
            tableView.reloadRows(at: indexPaths, with: .automatic)
        } else {
            ToDoStore.shared.addItem(ToDoDetailVC.listItem)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        
    }
    
    // Mark: - switch for the section on the table view.
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "HOME"
        case 1:
            return "WORK"
        case 2:
            return "PERSONAL"
        default:
            return "UNCATEGORIZED"
        }
    }
    
    

}
