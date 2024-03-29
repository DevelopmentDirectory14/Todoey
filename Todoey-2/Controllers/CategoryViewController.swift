//
//  CategoryViewController.swift
//  Todoey-2
//
//  Created by Aleksey Shapoval on 10/10/19.
//  Copyright © 2019 VoVa LLC. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 80.0
    }

    //MARK - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
        
            cell.textLabel?.text = category.name ?? "No Categories Added Yet."
            
            guard let categoryColor = UIColor(hexString: category.cellColor) else {fatalError()}
            
            cell.backgroundColor = categoryColor
          
            cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: categoryColor, isFlat: true)
        } 
        return cell
     }
    

    
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
            newCategory.cellColor = UIColor.randomFlat().hexValue()
            
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
    
//MARK: - Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
                    }
        
        }
    }
    
}



