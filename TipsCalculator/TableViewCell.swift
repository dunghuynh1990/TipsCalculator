//
//  TableViewCell.swift
//  TipsCalculator
//
//  Created by Huynh Tri Dung on 2/28/16.
//  Copyright © 2016 Huynh Tri Dung. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var percentage: UILabel!
    let defaults = NSUserDefaults.standardUserDefaults()
    var percentageItems:[Int] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        percentageItems.append(defaults.integerForKey("MinimumPercentage"))
        percentageItems.append(defaults.integerForKey("DefaultPercentage"))
        percentageItems.append(defaults.integerForKey("MaximumPercentage"))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func sliderValueChanged(slider: UISlider) {
        percentage.text = "\(Int(slider.value))%"
        switch slider.tag {
        case 0:
            defaults.setInteger(Int(slider.value), forKey: "MinimumPercentage")
        case 1:
            defaults.setInteger(Int(slider.value), forKey: "DefaultPercentage")
        case 2:
            defaults.setInteger(Int(slider.value), forKey: "MaximumPercentage")
        default:
            break
        }
        defaults.synchronize()
    }
}
