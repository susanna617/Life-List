//
//  myTableViewController.swift
//  Life list
//
//  Created by girlswhocode on 7/16/19.
//  Copyright © 2019 girlswhocode. All rights reserved.
//

import UIKit
import CoreData
class myTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    var tasks : [Task] = []
    
    @IBOutlet var mytableview: UITableView!
    
    func getdata(){
        do{
            let req: NSFetchRequest<Task> = Task.fetchRequest()
            //req.predicate = NSPredicate(format: "completeTest == FALSE", argumentArray: nil)
            tasks = try context.fetch(req)
//            if tasks == nil {
//                print("Tasks are NULLLLLL")
//            }
            tasks.sort(by: {$0.taskName!.caseInsensitiveCompare($1.taskName!) == .orderedAscending})
            
            for task in tasks {
                print(task.taskName)
            }
            DispatchQueue.main.async {
                //sorts tasks alphabetically (compares 2 things in an array to see which is higher up in the alphabet
                
                self.mytableview?.reloadData()
            }
        }catch{
            print("Couldn't fetch data!")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        getdata()
    }
    
  /*  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        
    }
    */
    override func viewDidLoad() {
        
        
        self.tableView.separatorStyle = .none

        super.viewDidLoad()
        
        //text below is supposed to change text of name of navigation "todo list"
        getdata()
        
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    


    var totalSeconds: Int64 = -1
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableview.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            as! myTableViewCell
        
        cell.delegate = self as! myTableViewCellDelegate
        cell.task = tasks[indexPath.row]
        
        
        cell.taskLabel.text = tasks[indexPath.row].taskName
        totalSeconds = tasks[indexPath.row].countdownSecond
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = ((totalSeconds % 3600) % 60)
        let finalTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        
        

        cell.timerLabel.text = finalTime

        
        return cell
    }
    
    

    
   // var countdownTimer: Timer!
    
   /* func endTimer() {
        countdownTimer.invalidate()
    }
    */



    /*
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    

    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours: Int = totalSeconds % 3600
        let minutes: Int = (totalSeconds % 3600) / 60
        let seconds = ((totalSeconds % 3600) % 60)
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let task = self.tasks[indexPath.row]
            self.context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self.tasks.remove(at: indexPath.row)

            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

        }
}


}
    


extension myTableViewController: myTableViewCellDelegate {
    func completeTask(cell: myTableViewCell) {
        //endTimer()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let index = tableView.indexPath(for: cell)!
        //endTimer()
        context.delete(tasks[index.row])
        tasks.remove(at: index.row)
        tableView.deleteRows(at: [index], with: .automatic)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    }
}

