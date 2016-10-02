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
    let defaults = UserDefaults.standard
    var percentageItems:[Int] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        percentageItems.append(defaults.integer(forKey: "MinimumPercentage"))
        percentageItems.append(defaults.integer(forKey: "DefaultPercentage"))
        percentageItems.append(defaults.integer(forKey: "MaximumPercentage"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func sliderValueChanged(_ slider: UISlider) {
        percentage.text = "\(Int(slider.value))%"
        switch slider.tag {
        case 0:
            defaults.set(Int(slider.value), forKey: "MinimumPercentage")
        case 1:
            defaults.set(Int(slider.value), forKey: "DefaultPercentage")
        case 2:
            defaults.set(Int(slider.value), forKey: "MaximumPercentage")
        default:
            break
        }
        defaults.synchronize()
    }
}
