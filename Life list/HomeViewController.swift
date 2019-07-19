//
//  HomeViewController.swift
//  Life list
//
//  Created by girlswhocode on 7/19/19.
//  Copyright © 2019 girlswhocode. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    let backroundImageView = UIImageView()
    
    let JournalViewControllerFile = JournalViewController()
    
    func setBackground() {
        view.addSubview(backroundImageView)
        backroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backroundImageView.image = UIImage(named: "Palms")
        view.sendSubviewToBack(backroundImageView)
    }
    
    func saveText(textName: String) {
        let text = JournalViewControllerFile.TextView.text
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newCurrText_var = CurrText_var(context: context)
        newCurrText_var.currText = text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
    @objc func text(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        // Do any additional setup after loading the view.
    }
    
    
}
