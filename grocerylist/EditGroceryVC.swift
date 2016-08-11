//
//  EditGroceryVC.swift
//  grocerylist
//
//  Created by Eric Giannini on 5/4/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit
import CoreData

class EditGroceryVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var quantityLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var editGroceryItem: GroceryItem!
    
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLbl.text = editGroceryItem.name
        
        self.quantityLbl.text = editGroceryItem.quantity?.stringValue
        
        self.descriptionLbl.text = editGroceryItem.details
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveBtnAction(sender: AnyObject) {
        

        editGroceryItem.setValue(nameTxtField.text!, forKey: "name")
        editGroceryItem.setValue(Int(quantityTxtField.text!), forKey: "quantity")
        editGroceryItem.setValue(descriptionTxtField.text!, forKey: "details")
        editGroceryItem.setValue(false, forKey: "purchased")
        
        do {
            try moc.save()
            print("Success!")
        } catch {
            fatalError("failure to save context: \(error)")
        }

        
        
        
        navigationController?.popToRootViewControllerAnimated(true)
        
        
        
    }


    @IBAction func addQntyBtnAction(sender: AnyObject) {
        
        
        if Int(quantityLbl.text!) < 10000 {
            let value = Int(quantityLbl.text!)! + 1
            quantityLbl.text = "\(value)"
        }
    
    }
    

    @IBAction func minusQntyBtnAction(sender: AnyObject) {
        
        if Int(quantityLbl.text!) > 0 {
            let value = Int(quantityLbl.text!)! - 1
            quantityLbl.text = "\(value)"
        }
        
    }


}


