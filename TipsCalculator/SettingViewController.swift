//
//  SettingViewController.swift
//  TipsCalculator
//
//  Created by Huynh Tri Dung on 2/28/16.
//  Copyright © 2016 Huynh Tri Dung. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var percentageItems:[Int] = []
    var percentageTag:[String] = []
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        percentageItems.append(defaults.integerForKey("MinimumPercentage"))
        percentageItems.append(defaults.integerForKey("DefaultPercentage"))
        percentageItems.append(defaults.integerForKey("MaximumPercentage"))
        
        percentageTag.append("Minimum")
        percentageTag.append("Default")
        percentageTag.append("Maximum")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerString:String = ""
        headerString = "Tip Percentage (%)"
        return headerString as String
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return percentageItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as! TableViewCell
        cell.name.text = percentageTag[indexPath.row]
        cell.percentage.text = "\(percentageItems[indexPath.row])%"
        if indexPath.row == 0 {
            cell.slider.minimumValue = 1
            cell.slider.maximumValue = 15
            cell.slider.value = Float(percentageItems[indexPath.row])
            cell.slider.tag = indexPath.row
        }else if indexPath.row == 1 {
            cell.slider.minimumValue = 16
            cell.slider.maximumValue = 30
            cell.slider.value = Float(percentageItems[indexPath.row])
            cell.slider.tag = indexPath.row
        }else if indexPath.row == 2 {
            cell.slider.minimumValue = 31
            cell.slider.maximumValue = 40
            cell.slider.value = Float(percentageItems[indexPath.row])
            cell.slider.tag = indexPath.row
        }
        return cell
    }
}
