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
        view.endEditing(true)
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
        cell.percentage.text = "\(percentageItems[indexPath.row])"
        if indexPath.row == 0 {
            cell.percentage.tag = 0
        }else if indexPath.row == 1 {
            cell.percentage.tag = 1
        }else if indexPath.row == 2 {
            cell.percentage.tag = 2
        }
        cell.percentage.addTarget(self, action: #selector(SettingViewController.textFieldDidChange(_:)), forControlEvents:UIControlEvents.EditingDidEnd)

        return cell
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func textFieldDidChange(textField: UITextField) {
        if (textField.text?.characters.count > 0 && Int(textField.text!) > 0) {
            switch textField.tag {
            case 0:
                if Int(textField.text!) >= percentageItems[1] {
                    showAlertView("Mininum tip percentage can not greater than or equal to Defaulf tip percentage.")
                    textField.text = "\(percentageItems[textField.tag ])"
                }else {
                    defaults.setInteger(Int(textField.text!)!, forKey: "MinimumPercentage")
                }
            case 1:
                if Int(textField.text!)! >= percentageItems[2] {
                    showAlertView("Default tip percentage can not greater than or equal to Maximum tip percentage.")
                    textField.text = "\(percentageItems[textField.tag ])"
                }else if Int(textField.text!)! <= percentageItems[0]{
                    showAlertView("Default tip percentage can not smaller than or equal to Minimum tip percentage.")
                    textField.text = "\(percentageItems[textField.tag ])"
                }else {
                    defaults.setInteger(Int(textField.text!)!, forKey: "DefaultPercentage")
                }
            case 2:
                if Int(textField.text!)! > 40 {
                    showAlertView("Mininum tip can not greater than 40%.")
                    textField.text = "\(percentageItems[textField.tag ])"
                }else if (Int(textField.text!)! <= percentageItems[1]){
                    showAlertView("Default tip percentage can not smaller than or equal to Default tip percentage.")
                    textField.text = "\(percentageItems[textField.tag ])"
                }else {
                    defaults.setInteger(Int(textField.text!)!, forKey: "MaximumPercentage")
                }
            default:
                break
            }
            defaults.synchronize()
        }else{
            textField.text = "\(percentageItems[textField.tag])"
        }
    }
    
    func showAlertView(messageText:String) -> Void {
        let alert = UIAlertController(title: "Alert", message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
