//
//  ViewController.swift
//  Calculator
//
//  Created by Jinisha Savani on 6/7/18.
//  Copyright © 2018 Jinisha Savani. All rights reserved.
//

import UIKit

enum modes {
    case not_set
    case addition
    case subtraction
    case multiplication
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var savedNum:Int = 0
    var currentMode:modes = .not_set
    var lastButtonWasMode:Bool = false
    var labelString:String = "0"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressPlus(_ sender: Any) {
        changeModes(newmode: .addition)
        
    }
    
    @IBAction func didPressSubtract(_ sender: Any) {
        changeModes(newmode: .subtraction)
        
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeModes(newmode: .multiplication)
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        
        if currentMode == .not_set || lastButtonWasMode {
            return
        }
        
        if currentMode == .addition {
            savedNum += labelInt
        }
        
        else if currentMode == .subtraction {
            savedNum -= labelInt
        }
        
        else if currentMode == .multiplication {
            savedNum *= labelInt 
        }
        
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        
        savedNum = 0
        labelString = "0"
        lastButtonWasMode = false
        currentMode = .not_set
        label.text = "0"
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        
        let stringValue:String? = sender.titleLabel?.text
        
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue!)
        updateText()
        
    }
    
    func updateText(){
        
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        
        if currentMode == .not_set{
            savedNum = labelInt
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let num:NSNumber = NSNumber(value: labelInt)
        
        label.text = formatter.string(from: num)
    }
    
    func changeModes(newmode: modes){
        if savedNum == 0 {
            return
        }
        else{
            currentMode = newmode
            lastButtonWasMode = true
        }
        
    }
    

    
}

