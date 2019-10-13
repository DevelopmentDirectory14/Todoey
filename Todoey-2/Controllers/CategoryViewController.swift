//
//  CategoryViewController.swift
//  Todoey-2
//
//  Created by Aleksey Shapoval on 10/10/19.
//  Copyright © 2019 VoVa LLC. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray = [Category]()
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    //MARK - Tableview Datasource Methods
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
     }
    
     //TODO: Declare numberOfRowsInSection here:
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               
        return categoryArray.count
           }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
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
             self.categoryArray.append(newCategory)

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
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        
//        do {
//            categoryArray = try context.fetch(request)
//        } catch {
//            print ("Error fetching data from context \(error)")
//        }
//        
//        tableView.reloadData()
    }
    
}
