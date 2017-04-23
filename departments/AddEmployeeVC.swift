//
//  AddEmployeeVC.swift
//  departments
//
//  Created by Sam Greenhill on 4/16/17.
//  Copyright © 2017 simplyAmazingMachines. All rights reserved.
//

import UIKit
import CoreData

class AddEmployeeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var firstName: UITextField!
    
    @IBOutlet var lastName: UITextField!
    
    @IBOutlet var designation: UITextField!
    
    @IBOutlet var departmentsPicker: UIPickerView!
    
    
    var appDel:  AppDelegate = AppDelegate()
    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    
    var pickerData = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDel = UIApplication.shared.delegate as! AppDelegate
        context = appDel.persistentContainer.viewContext
        //with context, we now have access to the core data module.
        departmentsPicker.dataSource = self
        departmentsPicker.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        populatePickerViewDataSource()
//        print(pickerData.count)

    
    
    }
    
    
    func populatePickerViewDataSource() {
     //a fetch request. 
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Departments")
        request.resultType = .managedObjectResultType
        
        do {
            
            let results = try context.fetch(request)
            pickerData = results as! [NSManagedObject]
            
            
        } catch {
            print("Error in fetching records.")
        }
        
        
        
        
    }


    
    
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        if pickerData.count == 0 {
            print("No Department records Found. New Employee cannot be added without department")
            func showAlert(title: String, message: String, vc: UIViewController) {
                let alert = UIAlertController(title: "Error", message: "No Department records Found. New Employee cannot be added without department", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                vc.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        if firstName.text == "" || lastName.text == "" || designation.text == "" {
            print("All Fields need to be fileld. Record can't be saved.")
            func showAlert(title: String, message: String, vc: UIViewController) {
                let alert = UIAlertController(title: "Error", message: "All Fields need to be fileld. Record can't be saved.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                vc.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        let newEmployeee = NSEntityDescription.insertNewObject(forEntityName: "Employees", into: context)
        
        newEmployeee.setValue(firstName.text, forKey: "firstName")
        newEmployeee.setValue(lastName.text, forKey: "lastName")
        newEmployeee.setValue(designation.text, forKey: "designation")
        //i think the forKey is the key we created in the coredata that will hold that data. 
        
        let selectedDeparment = pickerData[departmentsPicker.selectedRow(inComponent: 0)]
        newEmployeee.setValue(selectedDeparment, forKey: "department")
        //department is the name of the relationship that we defined. 
        
        
        do {
            try context.save()
            print("record Saved successfully.")
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("issue with saving record.")
        }
        
    }


    //MARK: - pickerView Delegate Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return (pickerData[row].value(forKey: "name") as! String)
        //pickerData with the help of this row index we are grabbing the object nsmanagedobject. from that object give us the value for key name. that value for key name named "name" which is of type any, so we need to cast it to type string.
    }
    
    
    
    
    
    
    
}
