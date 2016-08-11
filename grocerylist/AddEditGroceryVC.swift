//
//  AddEditGroceryVC.swift
//  grocerylist
//
//  Created by Eric Giannini on 5/4/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit
import CoreData

class AddEditGroceryVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - References & Properties
    
    let moc = CoreDataController().managedObjectContext

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var quantityTxtField: UITextField!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var descriptionTxtField: UITextField!
    
    var editGroceryItem: GroceryItem?
    
    
    // MARK: - Methods
    
    private var isEditingMode: Bool {
        
        return editGroceryItem != nil
        
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if (isEditingMode) {
        
//            nameTxtField.text = editGroceryItem?.name
            nameTxtField.hidden = true
            nameLbl.hidden = true
            
            quantityTxtField.text = editGroceryItem?.quantity?.stringValue
            
//            descriptionTxtField.text = editGroceryItem?.details
            descriptionTxtField.hidden = true
            descriptionLbl.hidden = true
            
        }
        
        quantityTxtField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Actions
    
    @IBAction func saveBtnAction(sender: AnyObject) {
        
        if (isEditingMode) {
            
//            editGroceryItem?.setValue(nameTxtField.text!, forKey: "name")
            
            editGroceryItem?.setValue(Int(quantityTxtField.text!), forKey: "quantity")
//            editGroceryItem?.setValue(descriptionTxtField.text!, forKey: "details")
//            editGroceryItem?.setValue(false, forKey: "purchased")
            
            do {
                try editGroceryItem?.managedObjectContext?.save()  
//                print("Success!")
            } catch {
                fatalError("failure to save context: \(error)")
            }

            
        } else {
        
            let entity = NSEntityDescription.insertNewObjectForEntityForName("GroceryItem", inManagedObjectContext: moc) as! GroceryItem
            entity.setValue(nameTxtField.text!, forKey: "name")
            entity.setValue(Int(quantityTxtField.text!), forKey: "quantity")
            entity.setValue(descriptionTxtField.text!, forKey: "details")
            entity.setValue(false, forKey: "purchased")
            
            do {
                try moc.save()
//                print("Success!")
            } catch {
                fatalError("failure to save context: \(error)")
            }
        
        }
        navigationController?.popToRootViewControllerAnimated(true)
        
    }

}
