//
//  AddPlayer.swift
//  Assignment3
//
//  Created by Uday Kiran Reddy Vatti on 4/7/16.
//  Copyright (c) 2016 Uday Kiran Reddy Vatti , Sreya Nooli. All rights reserved.
//
import UIKit

class AddPlayer: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    var play: Player?
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var height: UITextField!
    
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var position: UITextField!
    
    @IBOutlet weak var uniformNumber: UITextField!
    
    @IBOutlet weak var DOB: UITextField!
    
    @IBOutlet weak var bats: UISegmentedControl!
    
    @IBOutlet weak var throws: UISegmentedControl!
    

    @IBAction func dobPressed(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    @IBAction func backgroundTapped(sender: AnyObject) {
        height.endEditing(true)
        firstName.endEditing(true)
        lastName.endEditing(true)
        weight.endEditing(true)
        position.endEditing(true)
        uniformNumber.endEditing(true)
        DOB.endEditing(true)
        
    }
    let feetComponent = 0
    let inchComponent = 1
    var samp  = "1'"
    var samp1 = "1''"
    
    
    let ft = ["1'","2'","3'","4'","5'","6'","7'","8'"]
   
    let inch = ["1''","2''","3''","4''","5''","6''","7''","8''","9''","10''","11''"]
    
    let wt = ["150","151","152","153","154","155","156","157","158","159",
                    "160","161","162","163","164","165","166","167","168","169",
                    "170","171","172","173","174","175","176","177","178","179",
                        "180","181","182","183","184","185","186","187","188","189",
                    "190","191","192","193","194","195","196","197","198","199",
                    "200","201","202","203","204","205","206","207","208","209"]
    
    let pos = ["P","1B","2B","SS","3B","LF","CF","RF","C","DH"]
    
    let num = ["1","2","3","4","5","6","7","8","9","10","11", "160","161","162","163","164","165","166","167","168","169",
        "170","171","172","173","174","175","176","177","178","179",
        "180","181","182","183","184","185","186","187","188","189"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerHeight = UIPickerView()
        pickerHeight.dataSource = self
        pickerHeight.delegate = self
        height.inputView = pickerHeight
        
        let pickerWeight = UIPickerView()
        pickerWeight.dataSource = self
        pickerWeight.delegate = self
        weight.inputView = pickerWeight
        
        let pickerPosition = UIPickerView()
        pickerPosition.dataSource = self
        pickerPosition.delegate = self
        position.inputView = pickerPosition
        
        
        let pickerNumber = UIPickerView()
        pickerNumber.dataSource = self
        pickerNumber.delegate = self
        uniformNumber.inputView = pickerNumber
        
        pickerHeight.tag = 0
        pickerWeight.tag = 1
        pickerPosition.tag = 2
        pickerNumber.tag = 3
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Navigation

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if segue.identifier == "savePlayerDetail" {
            var playType : String  = ""
            var hand : String = ""
            var b = bats.selectedSegmentIndex
            if b == 0
            {
                hand = "R"
            }
            if b == 1{
                hand = "L"
            }
            var c = throws.selectedSegmentIndex
            var t : String = ""
            if c == 0
            {
                t = "R"
            }
            if c == 1{
                t = "L"
            }
            
            if position.text == "P"
            {
                playType = "Pitcher"
            }
            if position.text == "1B" || position.text == "2B" || position.text == "SS" || position.text == "3B"
            {
                playType = "Infield"
            }
            if position.text == "LF" || position.text == "CF" || position.text == "RF"
            {
                playType = "Outfield"
            }
            if position.text == "C" || position.text == "DH"
            {
                playType = "Other"
            }
            play = Player(Number: uniformNumber.text, FirstName: firstName.text, LastName: lastName.text, Position: position.text, Bats:hand , Throws: t, Height: height.text, Weight: weight.text, DOB: DOB.text, playType: playType)
        //}
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    // Picker for all
    func handleDatePicker(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        DOB.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0
        {
        if component == 0 {
        return ft.count
        }
        if component == 1{
            return inch.count
        }
        }
        else if pickerView.tag == 1{
            return wt.count
        }
        else if pickerView.tag == 2{
            return pos.count
        }
        else if pickerView.tag == 3{
            return num.count
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if pickerView.tag == 0{
        if component == 0{
        return ft[row]
        }
        if component == 1{
            return inch[row]
        }
        }
        else if pickerView.tag == 1{
            return wt[row]
        }
        else if pickerView.tag == 2{
            return pos[row]
        }
        else if pickerView.tag == 3{
            return num[row]
        }
        return ""
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0{
            return 2
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView.tag == 0 {
        if component == 0{
         samp = ft[row]
        }
        if component == 1{
         samp1 = inch[row]
        }
        
        height.text = samp + " "+samp1
    }
        else if pickerView.tag == 1{
            weight.text = wt[row]
        }
        else if pickerView.tag == 2{
            position.text = pos[row]
        }
        else if pickerView.tag == 3{
            uniformNumber.text = num[row]
        }
    }

    
}

