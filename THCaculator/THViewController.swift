//
//  ViewController.swift
//  THCaculator
//
//  Created by Hai on 11/5/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit

class THViewController: UIViewController {
    

    @IBOutlet weak var lbDisplay: UILabel!
    
    var subTotal: Float?
    var firstValue = true
    var temp : Float?
    var combo = false
    var minus = false
    var dec = false
    
    enum operatorType {
        case add
        case minus
        case mutiply
        case divide
    }
    
    var lastOperatorType : operatorType?
    
    
    func UIsetUp() {
        for i in 1..<20 {
            
            self.view.backgroundColor = .none
            let button = view.viewWithTag(i) as! UIButton
            button.layer.borderWidth = 0.25
            button.layer.borderColor = UIColor.black.cgColor
            button.setTitleColor(.black, for: .normal)
            if button.isTouchInside == true {
                button.layer.backgroundColor = UIColor.gray.cgColor
            }
        }

    }
    func showResult(show : Float) -> String{
        let tempVar = String(format: "%g", show)
        return tempVar
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIsetUp()
        
    }
    
    @IBAction func invokeBtnEqual(_ sender: AnyObject) {
        var result : Float?
        if let finalOperatorType = lastOperatorType {
            switch finalOperatorType {
            case .add:
                result = subTotal! + Float(lbDisplay.text!)!
            case .minus :
                result = subTotal! - Float(lbDisplay.text!)!
            case .mutiply :
                if combo == true {
                    if minus == true {
                        result = temp! - subTotal! * Float(lbDisplay.text!)!
                    } else {
                        result = temp! + subTotal! * Float(lbDisplay.text!)!
                        print(temp!)
                    }
                }
                else {
                    result = subTotal! * Float(lbDisplay.text!)!
                }
            case .divide :
                if combo == true {
                    if minus == true {
                        result = temp! - subTotal! / Float(lbDisplay.text!)!
                    } else {
                        result = temp! + subTotal! / Float(lbDisplay.text!)!
                        print(temp!)
                    }
                } else {
                    result = subTotal! / Float(lbDisplay.text!)!
                }
            default : break
            }
            
            self.lbDisplay.text = showResult(show: result!)
            self.subTotal = nil
            self.firstValue = true
            self.combo = false
            self.minus = false
            self.temp = nil
            self.lastOperatorType = nil
            
        }
        
        
    }

   
    @IBAction func invokeBtn1(_ sender: AnyObject) {
        numberClick(number: 1)
    }
    
    @IBAction func invokeBtn2(_ sender: AnyObject) {
        numberClick(number: 2)
    }

    @IBAction func invokeBtn3(_ sender: AnyObject) {
         numberClick(number: 3)
    }
    @IBAction func invokeBtn4(_ sender: AnyObject) {
         numberClick(number: 4)
    }
    @IBAction func invokeBtn5(_ sender: AnyObject) {
         numberClick(number: 5)
    }
    @IBAction func invokeBtn6(_ sender: AnyObject) {
         numberClick(number: 6)
    }
    @IBAction func invokeBtn7(_ sender: AnyObject) {
         numberClick(number: 7)
    }
    @IBAction func invokeBtn8(_ sender: AnyObject) {
         numberClick(number: 8)
    }
    @IBAction func invokeBtn9(_ sender: AnyObject) {
         numberClick(number: 9)
    }
    @IBAction func invokeBtn0(_ sender: AnyObject) {
         numberClick(number: 0)
    }
    @IBAction func invokeBtnAdd(_ sender: AnyObject) {
        if let currentTotal = subTotal {
            subTotal = Float(lbDisplay.text!)! +  currentTotal
        } else {
            subTotal = Float(lbDisplay.text!)!
        }
        firstValue = true
        lastOperatorType = operatorType.add
        lbDisplay.text = showResult(show: self.subTotal!)
        
    }
    @IBAction func invokeBtnMinus(_ sender: AnyObject) {
        if let currentTotal = subTotal {
            subTotal = Float(lbDisplay.text!)! -  currentTotal
        } else {
            subTotal = Float(lbDisplay.text!)!
        }
        firstValue = true
        lastOperatorType = operatorType.minus
        lbDisplay.text = showResult(show: self.subTotal!)
        
    }
    @IBAction func invokeBtnDivide(_ sender: AnyObject) {
        if ( lastOperatorType == operatorType.add || lastOperatorType == operatorType.minus) {
            if lastOperatorType == operatorType.add {
                self.temp = subTotal!
            } else {
                self.temp = subTotal!
                minus = true
            }
            self.combo = true
            subTotal = Float(lbDisplay.text!)!
        }
            
        else {
            if let currentTotal = subTotal {
                subTotal = Float(lbDisplay.text!)! /  currentTotal
            } else {
                subTotal = Float(lbDisplay.text!)!
            }
        }
        lastOperatorType = operatorType.divide
        lbDisplay.text = showResult(show: self.subTotal!)

        firstValue = true

    }
    @IBAction func invokeBtnMuti(_ sender: AnyObject) {
        if ( lastOperatorType == operatorType.add || lastOperatorType == operatorType.minus) {
            if lastOperatorType == operatorType.add {
                self.temp = subTotal!
            } else {
                self.temp = subTotal!
                self.minus = true
            }
            self.combo = true
            subTotal = Float(lbDisplay.text!)!
        }
       
        else {
            if let currentTotal = subTotal {
                subTotal = Float(lbDisplay.text!)! *  currentTotal
            } else {
                subTotal = Float(lbDisplay.text!)!
            }
        }
        firstValue = true
        lastOperatorType = operatorType.mutiply
        lbDisplay.text = showResult(show: self.subTotal!)

    }
    
    @IBAction func invokeBtnAC(_ sender: AnyObject) {
        self.lbDisplay.text = "0"
        self.subTotal = nil
        self.firstValue = true
        self.combo = false
        self.minus = false

    }
    @IBAction func invokeBtnPercent(_ sender: AnyObject) {
        let percent = Float(self.lbDisplay.text!)! / 100
        self.lbDisplay.text = showResult(show: percent)
    }
    @IBAction func invokeBtnAddMinus(_ sender: AnyObject) {
        let minusAdd = -1 * Float(self.lbDisplay.text!)!
        self.lbDisplay.text = showResult(show: minusAdd)
    }
    
    @IBAction func invokeBtnDec(_ sender: AnyObject) {
        self.dec = true
    }
    func numberClick(number: Int ) {
        if firstValue {
            self.lbDisplay.text = "\(number)"
            firstValue = false
        } else {
           
            if self.dec == true {
                self.lbDisplay.text = self.lbDisplay.text! + ".\(number)"
                self.dec = false
            }else {
                self.lbDisplay.text = self.lbDisplay.text! + "\(number)"
            }
        }

    }
}

