//
//  AddTimeViewController.swift
//  Life list
//
//  Created by girlswhocode on 7/18/19.
//  Copyright © 2019 girlswhocode. All rights reserved.
//

import UIKit
import CoreData

class AddTimeViewController: UIViewController {
    var task: Task?

    var Controller = myTableViewController()

    @IBOutlet weak var newDatePicker: UIDatePicker!
    

    var currSeconds: Int64 = -1
    
    
    @IBAction func newAlarmButton(_ sender: Any) {
        addNewAlarm()
    }

    /*override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if(segue.identifier == "backToTableView") {
            let vc = segue.destination as! myTableViewController
            vc.totalSeconds = currSeconds
            print(vc.totalSeconds)
            
        }
    }
    */
   func addNewAlarm(){
          let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
           // let newTask = Task(context: context)
            currSeconds = Int64(newDatePicker.countDownDuration)
        task?.countdownSecond = currSeconds
        dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
          (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
        
    //var blah  = [Task]() // Where Locations = your NSManaged Class
    
    //let fetchRequest = NSFetchRequest(entityName: "Task")
    let req: NSFetchRequest<Task> = Task.fetchRequest()
   // blah = context.fetch(req as! NSFetchRequest<NSFetchRequestResult>) as! [Task]
    
    // Then you can use your properties.
    

    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    


}   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


