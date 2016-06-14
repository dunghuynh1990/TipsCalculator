//
//  ViewController.swift
//  TipsCalculator
//
//  Created by Huynh Tri Dung on 2/28/16.
//  Copyright © 2016 Huynh Tri Dung. All rights reserved.
//

import UIKit

extension Double {
    var asLocaleCurrency:String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(self)!
    }
}

class TipViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txfBill: UITextField!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var percentageItems:[Int] = []
    var zeroBill = 0.0
    
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        txfBill.placeholder = zeroBill.asLocaleCurrency
        lblTip.text = zeroBill.asLocaleCurrency
        lblTotal.text = zeroBill.asLocaleCurrency
        txfBill.becomeFirstResponder()

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
        if (Double(txfBill.text!)==0 && (txfBill.text?.isEmpty) != nil) {
            txfBill.text = ""
        }else {
            if let billAmount = Double(txfBill.text!) {
                let tipPercentage = Double(percentageItems[tipControl.selectedSegmentIndex]) * 0.01
                let tip = billAmount * tipPercentage
                let total = billAmount + tip
                lblTip.text = tip.asLocaleCurrency
                lblTotal.text = total.asLocaleCurrency
            }else {
                lblTip.text = zeroBill.asLocaleCurrency
                lblTotal.text = zeroBill.asLocaleCurrency
                return
            }
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10 // Bool
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
}