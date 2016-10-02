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
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        percentageItems.append(defaults.integer(forKey: "MinimumPercentage"))
        percentageItems.append(defaults.integer(forKey: "DefaultPercentage"))
        percentageItems.append(defaults.integer(forKey: "MaximumPercentage"))
        
        percentageTag.append("Minimum")
        percentageTag.append("Default")
        percentageTag.append("Maximum")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerString:String = ""
        headerString = "Tip Percentage (%)"
        return headerString as String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return percentageItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! TableViewCell
        cell.name.text = percentageTag[(indexPath as NSIndexPath).row]
        cell.percentage.text = "\(percentageItems[(indexPath as NSIndexPath).row])%"
        if (indexPath as NSIndexPath).row == 0 {
            cell.slider.minimumValue = 1
            cell.slider.maximumValue = 15
            cell.slider.value = Float(percentageItems[(indexPath as NSIndexPath).row])
            cell.slider.tag = (indexPath as NSIndexPath).row
        }else if (indexPath as NSIndexPath).row == 1 {
            cell.slider.minimumValue = 16
            cell.slider.maximumValue = 30
            cell.slider.value = Float(percentageItems[(indexPath as NSIndexPath).row])
            cell.slider.tag = (indexPath as NSIndexPath).row
        }else if (indexPath as NSIndexPath).row == 2 {
            cell.slider.minimumValue = 31
            cell.slider.maximumValue = 40
            cell.slider.value = Float(percentageItems[(indexPath as NSIndexPath).row])
            cell.slider.tag = (indexPath as NSIndexPath).row
        }
        return cell
    }
}
