//
//  EmployeesTVC.swift
//  departments
//
//  Created by Sam Greenhill on 4/16/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit
import CoreData

class EmployeesTVC: UITableViewController {


    
    var appDel:  AppDelegate = AppDelegate()
    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    var employees = [NSManagedObject]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        appDel = UIApplication.shared.delegate as! AppDelegate
        context = appDel.persistentContainer.viewContext
        //with context, we now have access to the core data module.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        populateEmployees()
    }
    
    func populateEmployees() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employees")
        request.resultType = .managedObjectResultType
        
        
        do {
            let results = try context.fetch(request)
            employees = results as! [NSManagedObject]
            tableView.reloadData()
        } catch {
            print("Error in fetching employee Records")
        }
    }
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmployeeTVCell

        // Configure the cell...
        
        let firstName = employees[indexPath.row].value(forKey: "firstName") as! String
        let lastName = employees[indexPath.row].value(forKey: "lastName") as! String
        let fullName = firstName + " " + lastName
        
        let department = employees[indexPath.row].value(forKey: "department") as! NSManagedObject
        let departmentName = department.value(forKey: "name") as! String
        
        let designation = employees[indexPath.row].value(forKey: "designation") as! String
        
        cell.nameLbl.text = fullName.capitalized
        cell.designationLbl.text = designation.capitalized
        cell.destinationLbl.text = departmentName.capitalized

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let objectToDelete = employees[indexPath.row]
            context.delete(objectToDelete)
            
            //we have to save out context so we need to do a do try catch. 
            do {
                try context.save()
                employees.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                print("Record Deleted Successfully.")
            } catch {
                print("Error with deleting Record")
            }
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
   
    }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    }
