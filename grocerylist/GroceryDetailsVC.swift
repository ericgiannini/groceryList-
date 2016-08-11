//
//  GroceryDetailsVC.swift
//  grocerylist
//
//  Created by Eric Giannini on 8/4/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit

class GroceryDetailsVC: UIViewController {
    
    // MARK: - References & Properties
    
    var groceryItemPeekPop : GroceryItem!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.nameLabel.text = groceryItemPeekPop?.name
        
        self.quantityLabel.text = groceryItemPeekPop?.quantity?.stringValue
        
        self.descriptionLabel.text = groceryItemPeekPop?.details
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
