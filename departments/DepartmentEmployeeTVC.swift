//
//  DepartmentEmployeeTVC.swift
//  departments
//
//  Created by Sam Greenhill on 4/16/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit
import CoreData

class DepartmentEmployeeTVC: UITableViewController {

//    var appDel:  AppDelegate = AppDelegate()
//    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    @IBOutlet var navigationTitle: UINavigationItem!
    
    var selectedDepartment: NSManagedObject?
    
    
    var employees = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        appDel = UIApplication.shared.delegate as! AppDelegate
//        context = appDel.persistentContainer.viewContext
        //with context, we now have access to the core data module.
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //populateEmployees()
        let departmentName = selectedDepartment?.value(forKey: "name") as! String
        navigationTitle.title = departmentName
        let predicate = NSPredicate(format: "department = %@", selectedDepartment!)
        employees = fetchData(entityName: "Employees", predicate: predicate, sortDescriptor: nil)
        tableView.reloadData()
    }

    
    
//    func populateEmployees() {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employees")
//        request.resultType = .managedObjectResultType
//        
//        let predicate = NSPredicate(format: "department = %@", selectedDepartment!)
//        
//        request.predicate = predicate
//        
//        
//        do {
//            let results = try context.fetch(request)
//            employees = results as! [NSManagedObject]
//            
//            tableView.reloadData()
//        } catch {
//            print("Error in fetching department employees records")
//        }
//        
//    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return employees.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...

        //remember to grab data from NSManagedbjects
        let firstName = employees[indexPath.row].value(forKey: "firstName") as! String
        let lastName = employees[indexPath.row].value(forKey: "lastName") as! String
        let fullName = firstName + " " + lastName
        
        let designation = employees[indexPath.row].value(forKey: "designation") as! String
        
        cell.textLabel?.text = fullName
        cell.detailTextLabel?.text = designation
        
        
        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//    }
}
