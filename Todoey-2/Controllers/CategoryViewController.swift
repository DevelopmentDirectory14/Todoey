//
//  CategoryViewController.swift
//  Todoey-2
//
//  Created by Aleksey Shapoval on 10/10/19.
//  Copyright © 2019 VoVa LLC. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
        tableView.rowHeight = 80.0
    }

    //MARK - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet."
        cell.delegate = self
        
        return cell
     }
    
// Code from SwipeCellKit
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
     //TODO: Declare numberOfRowsInSection here:
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               
        return categories?.count ?? 1
           }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
         
        var textField = UITextField()
         
         let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
         
         let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
             //what happens after the user clicks the Add Item button on our UIAlert
             
            
             let newCategory = Category()
             newCategory.name = textField.text!

            self.save(category: newCategory)
        
         }
         
         alert.addTextField { (alertTextField) in
             alertTextField.placeholder = "Create new category"
             textField = alertTextField
         }
         
         alert.addAction(action)
         
         present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    
    func save(category: Category) {

        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
}

//MARK: - Swipe Cell Delegate Methods

extension CategoryViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
   
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Item Deleted")
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }

}
