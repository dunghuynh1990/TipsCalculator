//
//  TableViewCell.swift
//  TipsCalculator
//
//  Created by Huynh Tri Dung on 2/28/16.
//  Copyright © 2016 Huynh Tri Dung. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var percentage: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
