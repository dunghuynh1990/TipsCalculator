//
//  ViewController.swift
//  TipsCalculator
//
//  Created by Huynh Tri Dung on 2/28/16.
//  Copyright © 2016 Huynh Tri Dung. All rights reserved.
//

//================
//TODO: Auto layout
//TODO: Use stepper in Setting View
//TODO: Add animation
//TODO: Use system icon

/*
 [ ] UI animations * 
 [ ] Remembering the bill amount across app restarts (if <10mins) * 
 [ ] Using locale-specific currency and currency thousands separators. * 
 [ ] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.
*/

import UIKit

extension Double {
    var asLocaleCurrency:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
//        return formatter.string(from:NSNumber(self))!
        return formatter.string(from: NSNumber(value: self))!
        
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        percentageItems.append(defaults.integer(forKey: "MinimumPercentage"))
        percentageItems.append(defaults.integer(forKey: "DefaultPercentage"))
        percentageItems.append(defaults.integer(forKey: "MaximumPercentage"))
        for i in 0...2 {
            tipControl.setTitle(String(format:"%d %%",percentageItems[i]), forSegmentAt:i)
        }
        tipControl.selectedSegmentIndex = 1
        txfBill.placeholder = zeroBill.asLocaleCurrency
        lblTip.text = zeroBill.asLocaleCurrency
        lblTotal.text = zeroBill.asLocaleCurrency
        txfBill.becomeFirstResponder()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        percentageItems = []
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: textfield
    @IBAction func onEditingChanged(_ sender: AnyObject) {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10 // Bool
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
}
