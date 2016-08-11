//
//  GroceryListVC.swift
//  grocerylist
//
//  Created by Eric Giannini on 5/4/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit
import CoreData

class GroceryListVC: UITableViewController, UIViewControllerPreviewingDelegate {
    
    // MARK: - References & Properties
    
    // reference for BarButtonItem
    @IBOutlet weak var deleteBarBtnItem: UIBarButtonItem!
    
    // constant for managedObjectContext
    let moc = CoreDataController().managedObjectContext
    
    // variable for peek & pop
    var previewingContext: AnyObject?
    
    // variable for the list of groceries
    var groceryListArray = [GroceryItem]()
    
    
    // MARK: - Methods
    
    // function for reloading the list of groceries
    private func reloadList() {
        
         fetch()
         tableView.reloadData()
        
    }
    
    // function for fetching our managedObjectContext
    private func fetch() {
        
        let groceryItemFetch = NSFetchRequest(entityName: "GroceryItem")
        
        do {
            let fetchedGroceryItem = try moc.executeFetchRequest(groceryItemFetch) as? [GroceryItem]
            
            self.groceryListArray = fetchedGroceryItem!
            
        } catch {
//            fatalError("The fetchRequest failed: \(error)")
        }
    }
    
    // function for checking whether forced touch is available
    func isForceTouchAvailabel() -> Bool {
        return traitCollection.forceTouchCapability == .Available
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (isForceTouchAvailabel()) {
            self.previewingContext = registerForPreviewingWithDelegate(self, sourceView: self.view)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        reloadList()
    }
    
    override func viewDidDisappear(animated: Bool) {
        editing = false
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryListArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groceryCell", forIndexPath: indexPath) as? GroceryCell
        
        let groceryData = groceryListArray[indexPath.row]
        
        cell!.nameLbl.text = groceryData.name
        
        // configuring cell for status of purchase
        
        cell!.purchaseBtn.tag = indexPath.row
        
        cell!.purchaseBtn.selected = groceryData.purchased!.boolValue
        
        cell!.purchaseBtn.addTarget(self, action: #selector(GroceryListVC.purchasedBtnTapped(_:)), forControlEvents: .TouchUpInside)
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        performSegueWithIdentifier("SegueEditGroceryVC", sender: cell)

    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            moc.deleteObject(groceryListArray[indexPath.row])
            
            do {
                try moc.save()
                
//                print("Success!")
                
            } catch {
                
                fatalError("failure to save context: \(error)")
                
            }
                
            reloadList()
                
            } else if editingStyle == .Insert {
            
            }
    }

    // action for editing tableViewCells

    @IBAction func editTableViewCells(sender: AnyObject) {
        
        if editing == true {
            
            editing = false
            
            deleteBarBtnItem.title = "Delete"
        
        } else {
            
            editing = true
            
            deleteBarBtnItem.title = "Done"

            
        }
    }
    
    
    // MARK: - Actions
    
    func purchasedBtnTapped(sender: UIButton) {
        
        let groceryItem = groceryListArray[sender.tag]
        groceryItem.setValue(!sender.selected, forKey: "purchased")
        
        do {
            try groceryItem.managedObjectContext?.save()
//            print("Success!")
        } catch {
            fatalError("failure to save context: \(error)")
        }
        
        reloadList()
        
    }

    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SegueEditGroceryVC", let incomingVC = segue.destinationViewController as? AddEditGroceryVC {
        
            if let cell = sender as? UITableViewCell, let indexPath = self.tableView.indexPathForCell(cell) {
            
                incomingVC.editGroceryItem = groceryListArray[indexPath.row]
                
                incomingVC.title = "Edit Grocery Item"
                
            }
        }
        
    }
    
    // MARK: - Navigation - Peek & Pop
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if (self.presentedViewController is GroceryDetailsVC) {
            return nil
        }
        
        let cellPosition = self.tableView.convertPoint(location, fromView: self.view)
        let indexPath = self.tableView.indexPathForRowAtPoint(cellPosition)
        
        if indexPath != nil {
            
            let cell = tableView.cellForRowAtIndexPath(indexPath!)
            let groceryDetailsVC = storyboard?.instantiateViewControllerWithIdentifier("peekPop") as! GroceryDetailsVC
            groceryDetailsVC.groceryItemPeekPop = groceryListArray[indexPath!.row]
            previewingContext.sourceRect = self.view.convertRect((cell?.frame)!, fromView: self.tableView)
            return groceryDetailsVC
        }
        
        return nil
        
    }

    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        self.navigationController?.showViewController(viewControllerToCommit, sender: nil)
    }
    



}