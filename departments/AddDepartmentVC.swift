//
//  AddDepartmentVC.swift
//  departments
//
//  Created by Sam Greenhill on 4/16/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit
import CoreData


class AddDepartmentVC: UIViewController {

    
    @IBOutlet var departmentName: UITextField!
    var appDel:  AppDelegate = AppDelegate()
    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDel = UIApplication.shared.delegate as! AppDelegate
        context = appDel.persistentContainer.viewContext
        //with context, we now have access to the core data module.
    }

    override func viewDidAppear(_ animated: Bool) {
        departmentName.text = ""
    }
    
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        if departmentName.text == "" {
            
            let alert = UIAlertController(title: "ERROR", message: "You must provide a department name", preferredStyle: .actionSheet)
            let button = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(button)
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            
            
            
            //check if text entered already exists in core data entity, then present output to user that record can not be saved. 
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Departments")
            request.resultType = .managedObjectResultType
            
            let predicate = NSPredicate(format: "name = %@", departmentName.text!)
            request.predicate = predicate
            
            do {
                let results = try context.fetch(request)
                let records = results as! [NSManagedObject]
                
                if records.count > 0 {
                    print("Record already exists")
                    
                    //means i have a record that already exist. 
                    return
                }
                
            } catch {
                print("Some ERROR Occured")
            }
            
            self.view.endEditing(true)
            //save department in department entity.
            let newDepartment = NSEntityDescription.insertNewObject(forEntityName: "Departments", into: context)
            newDepartment.setValue(departmentName.text, forKey: "name")
            
            do {
                
                
                try context.save()
                print("Record Saved Successfully")
                self.navigationController?.popViewController(animated: true)
                //this takes us back by a single ViewController. (USEFUL TO KNOW)
                
            } catch {
                print("Problem in saving Record to core data.")
                
            }
            
        }
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

}
