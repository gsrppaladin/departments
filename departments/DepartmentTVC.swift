//
//  DepartmentTVC.swift
//  departments
//
//  Created by Sam Greenhill on 4/16/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit
import CoreData

class DepartmentTVC: UITableViewController {

    var appDel:  AppDelegate = AppDelegate()
    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    var departmentsData = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDel = UIApplication.shared.delegate as! AppDelegate
        context = appDel.persistentContainer.viewContext
        //with context, we now have access to the core data module.    
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        populateDepartmentsData()
    }
    

    func populateDepartmentsData() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Departments")
        request.resultType = .managedObjectResultType
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            
           let results = try context.fetch(request)
            departmentsData = results as! [NSManagedObject]
            tableView.reloadData()
            
        } catch {
            
            
            print("Some Error Occured in Fetching Records.")
        }
        
    }
    
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return departmentsData.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        
        //configure the cell...
        
        let departmentObject = departmentsData[indexPath.row]
        let departmentName = departmentObject.value(forKey: "name") as! String
        
        cell.textLabel?.text = departmentName //departmentsData[indexPath.row].value(forKey: "name") as! String
     
        
        //now we have access to the nsmanaged object, then call .value for key.
        
        
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
            
            let objectToDelete = departmentsData[indexPath.row]
            context.delete(objectToDelete)
            
            do {
                
                try context.save()
                departmentsData.remove(at: indexPath.row)
                 tableView.deleteRows(at: [indexPath], with: .fade)
                print("Record deleted Successfully.")
            } catch {
                
                print("Error in deleting the record.")
            }
            
            
            
           
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
