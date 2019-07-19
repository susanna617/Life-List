//
//  ViewController.swift
//  Life list
//
//  Created by girlswhocode on 7/16/19.
//  Copyright © 2019 girlswhocode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func submit(_ sender: Any) {
        addNewTask()
    }

    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func addNewTask(){
        if (textfield.text != ""){
            let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
            let newTask = Task(context: context)
            newTask.taskName = textfield?.text
            textfield.resignFirstResponder()
            newTask.countdownSecond = Int64(datePicker.countDownDuration)
            navigationController?.popViewController(animated: true)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()

        }
    }
        

            
    
    override func viewDidLoad() {
        hideKeyboard()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}




