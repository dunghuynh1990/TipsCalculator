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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(0, -8, 0, 0)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        percentageItems.append(defaults.integerForKey("MinimumPercentage"))
        percentageItems.append(defaults.integerForKey("DefaultPercentage"))
        percentageItems.append(defaults.integerForKey("MaximumPercentage"))
        
        
        percentageTag.append("Maximum")
        percentageTag.append("Default")
        percentageTag.append("Minimum")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerString:String = ""
        headerString = "Tip Percentage"
        return headerString as String
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return percentageItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as! TableViewCell
        print(percentageTag[indexPath.row],percentageItems[indexPath.row])
        cell.name.text = percentageTag[indexPath.row]
        cell.percentage.text = "\(percentageItems[indexPath.row])"
        if indexPath.row == 0 {
            cell.percentage.tag = 0
        }else if indexPath.row == 1 {
            cell.percentage.tag = 1
        }else if indexPath.row == 2 {
            cell.percentage.tag == 2
        }
        cell.percentage.addTarget(self, action: "textFieldDidChange:", forControlEvents:UIControlEvents.EditingDidEnd)

        return cell
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func textFieldDidChange(textField: UITextField) {
        let defaults = NSUserDefaults.standardUserDefaults()
        switch textField.tag {
        case 0:
            defaults.setInteger(Int(textField.text!)!, forKey: "MinimumPercentage")
        case 1:
            defaults.setInteger(Int(textField.text!)!, forKey: "DefaultPercentage")
        case 2:
            defaults.setInteger(Int(textField.text!)!, forKey: "MaximumPercentage")
        default:
            break
        }
        defaults.synchronize()
    }
    
}
