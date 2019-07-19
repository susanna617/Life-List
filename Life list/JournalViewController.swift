//
//  GalleryViewController.swift
//  Life list
//
//  Created by girlswhocode on 7/19/19.
//  Copyright © 2019 girlswhocode. All rights reserved.
//

import UIKit
import CoreData

class JournalViewController: UIViewController,UINavigationControllerDelegate, UITextViewDelegate {
    
    var counter = 0
    var savedImages: [String] = []
    
    
    
    
    @IBOutlet weak var TextView: UITextView!
    
    
    
   
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        hideKeyboard()
        TextView.text = "Insert Text"
        TextView.textColor = UIColor.lightGray
        super.viewDidLoad()
        getCurrentDateTime()
        if !textTitles.isEmpty {
        }
        
        TextView.delegate = self
        TextView.text = "Insert Text"
        TextView.textColor = UIColor.lightGray
        
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if TextView.textColor == UIColor.lightGray {
            TextView.text = ""
            TextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if TextView.text == "" {
            
            TextView.text = "Insert Text"
            TextView.textColor = UIColor.lightGray
        }
    }
    
    func getCurrentDateTime(){
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        let str = formatter.string(from: Date())
        label.text = str
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func AddNewText() {
        if (TextView.text != ""){
            let context = (UIApplication.shared.delegate as!
                AppDelegate).persistentContainer.viewContext
            let newText = CurrText_var(context: context)
            newText.currText = TextView?.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            TextView.resignFirstResponder()
        }
    }
    
    
    @IBAction func SaveEntry(_ sender: Any) {
    AddNewText()
    }
    
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    
    var entries : [CurrText_var] = []
    var add: Int = 0
    var textTitles: [String] = []
    
    func getData() {
        print("getData")
        do {
            let req: NSFetchRequest<CurrText_var> = CurrText_var.fetchRequest()
            entries = try context.fetch(req)
            print(entries.count)
            if entries.count != 0 {
                TextView!.text = entries[add].currText
            }
            
        }catch{
            print("Couldn't fetch text!")
        }
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
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
        print(add)
    }
    
    
    @IBAction func rightButton(_ sender: Any) {
    add = add+1
        if add >= entries.count {
            add = entries.count - 1
            print(add)
        }
        if !entries.isEmpty {
            getData()
        }
        TextView!.text = entries[add].currText!
    }
    
    
    @IBAction func leftButton(_ sender: Any) {
        add = add-1
        if add < 0 {
            add = 0
        }
        
        if !entries.isEmpty {
            getData()
        }
        TextView!.text = entries[add].currText!
    }



}
