//
//  ViewController.swift
//  TipsCalculator
//
//  Created by Huynh Tri Dung on 2/28/16.
//  Copyright © 2016 Huynh Tri Dung. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var txfBill: UITextField!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var percentageItems:[Int] = []
    
    var zeroBill = "0.00",
    currencySign = "$"
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTip.text = currencySign+zeroBill
        lblTotal.text = currencySign+zeroBill
        txfBill.becomeFirstResponder()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        percentageItems.append(defaults.integerForKey("MinimumPercentage"))
        percentageItems.append(defaults.integerForKey("DefaultPercentage"))
        percentageItems.append(defaults.integerForKey("MaximumPercentage"))
        for i in 0...2 {
            tipControl.setTitle(String(format:"%d %%",percentageItems[i]), forSegmentAtIndex:i)
        }
        tipControl.selectedSegmentIndex = 1
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        percentageItems = []
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: textfield
    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentage = Double(percentageItems[tipControl.selectedSegmentIndex]) * 0.01
        if let billAmount = Double(txfBill.text!) {
            let tip = billAmount * tipPercentage
            let total = billAmount + tip
            lblTip.text = String(format: "$%.2f",tip)
            lblTotal.text = String(format: "$%.2f", total)
        }else {
            lblTip.text = currencySign+zeroBill
            lblTotal.text = currencySign+zeroBill
            return
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
}