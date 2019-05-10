//
//  ConverterViewController.swift
//  Calculator
//
//  Created by Brady Webb on 4/11/19.
//  Copyright © 2019 Brady Webb. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    @IBOutlet weak var inputDisplay: UITextField!
    @IBOutlet weak var outputDisplay: UITextField!
    
    var numberToBeConverted: String = ""
    var Negative = false
    var decimal = false
    
    @IBAction func numberButton(_ sender: UIButton) {
        numberToBeConverted += String(sender.tag-1)
        updateInputField()
    }

    @IBAction func Clear(_ sender: UIButton) {
        outputDisplay.text = currentConversion.output
        numberToBeConverted = ""
        updateInputField()
    }
    
    @IBAction func signSwitch(_ sender: UIButton) {
        if !numberToBeConverted.isEmpty {
            if !Negative {
                Negative = true
                numberToBeConverted = "-" + numberToBeConverted
            }else {
                Negative = false
                numberToBeConverted.remove(at: numberToBeConverted.startIndex)
            }
            updateInputField()
        }

    }
    
    @IBAction func decimal(_ sender: UIButton) {
        if decimal {
            return
        }
        numberToBeConverted += "."
        decimal = true
        updateInputField()
    }
    
    var inputValue: String = ""
    var outputValue: String = ""
    
    var conversions = [conversion(label: ConverterType.fToC, input: "°F", output: "°C"),
                       conversion(label: ConverterType.cToF, input: "°C", output: "°F"),
                       conversion(label: ConverterType.miToKm, input: "mi", output: "km"),
                       conversion(label: ConverterType.kmToMi, input: "km", output: "mi")]
    
    var currentConversion: conversion = conversion(label: ConverterType.fToC, input: "°F", output: "°C")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputValue = ""
        outputValue = ""
        inputDisplay.text = conversions[0].input
        outputDisplay.text = conversions[0].output
        currentConversion = conversions[0]
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func converterButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Converter", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        for convType in conversions {
            alert.addAction(UIAlertAction(title: convType.label.rawValue, style: UIAlertAction.Style.default, handler: { (alertAction) in
                self.inputDisplay.text = convType.input
                self.outputDisplay.text = convType.output
                self.currentConversion = convType
            }))
        }
        self.present(alert, animated:true, completion: nil)
    }
    @IBAction func handleInput(_ sender: UIButton) {
        numberToBeConverted += String(sender.tag)
        updateInputField()
    }
    func updateInputField() {
        inputDisplay.text = numberToBeConverted + " " + currentConversion.input
        convert()
    }
    func convert() {
        guard let input = Double(numberToBeConverted) else {
            return
        }
        var output:Double? = nil
        
        switch currentConversion.label {
        case .fToC:
            output = (input - 32) * 5/9
        case .cToF:
            output = (input * 9/5) + 32
        case .miToKm:
            output = (input / 0.62137)
        case .kmToMi:
            output = (input * 0.62137)
        }
        
        outputDisplay.text = String(format: "%.2f", output!) + " " + currentConversion.output
    }
}


