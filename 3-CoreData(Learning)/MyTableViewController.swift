//
//  MyTableViewController.swift
//  3-CoreData(Learning)
//
//  Created by Mac on 09.02.2023.
//

import UIKit
import CoreData

class MyTableViewController: UITableViewController {

    var fetchResultController: NSFetchedResultsController<User>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.fetchLimit = 115
        fetchRequest.sortDescriptors = [sortDescriptor]
        let context = CoreDataManager.instance.viewContext
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        try! fetchResultController.performFetch()
        
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        let user = User(context: CoreDataManager.instance.viewContext)
        user.name = "Bob \(Int.random(in: 0...100))"
        let book = Book(context: CoreDataManager.instance.viewContext)
        book.name = "Some book"
        user.book = book
        CoreDataManager.instance.saveContext()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return fetchResultController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {return 0}
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let user = fetchResultController.object(at: indexPath)
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.book?.name
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete :
            let object = fetchResultController.object(at: indexPath)
            CoreDataManager.instance.viewContext.delete(object)
            CoreDataManager.instance.saveContext()
        case .insert :
            return
        default: break
        }
    }
    

}

extension MyTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = indexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            return
        case .update:
            return
        default: break
        }
    }
}
