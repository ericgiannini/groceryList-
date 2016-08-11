//
//  GroceryCell.swift
//  grocerylist
//
//  Created by Eric Giannini on 8/4/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit

class GroceryCell: UITableViewCell {
    
    // MARK: - References
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var purchaseBtn: UIButton!

    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
