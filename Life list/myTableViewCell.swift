//
//  myTableViewCell.swift
//  Life list
//
//  Created by girlswhocode on 7/16/19.
//  Copyright © 2019 girlswhocode. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation


protocol myTableViewCellDelegate {
    func completeTask(cell: myTableViewCell)
}


class myTableViewCell: UITableViewCell {


    
    var Controllerb = AddTimeViewController()
    
    var Controllert = myTableViewController()
    
    var delegate: myTableViewCellDelegate?
    
    var task: Task?
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var taskLabel: UILabel!
    

    
    var isCounting = false
    
    @IBOutlet weak var pauseTimerOutlet: UIButton!
    
    @IBAction func pauseTimerButton(_ sender: Any) {
        if isCounting {
            endTimer()
        } else {
        startTimer()
        
        }

    }
    
    
    @IBAction func completeTaskButton(_ sender: Any) {
        delegate?.completeTask(cell: self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var countdownTimer: Timer?
    
    func timeFormatted(_ totalSeconds: Int64) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = ((totalSeconds % 3600) % 60)
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    @objc func updateTime() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let t = task else {
            endTimer()
            return
        }
        if t.countdownSecond == 0 {
            endTimer()
            AudioPlayer.shared.playMusic(music(rawValue: "BlindingLights")!)
            createAlert(title: "Time is up!", message: "task: \(task?.taskName ?? "")")
        } else {
            t.countdownSecond -= 1
        }
        timerLabel.text = timeFormatted(t.countdownSecond)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func createAlert(title:String, message:String){
        AudioPlayer.shared.playMusic(music(rawValue: "BlindingLights")!)
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            AudioPlayer.shared.stopPlayingMusic()
            //self.endTimer()
            //self.pauseTimerOutlet.isUserInteractionEnabled = false
        }))
        

 
        let story = UIStoryboard(name: "Main", bundle: nil)
        
        alert.addAction(UIAlertAction(title: "Add more time", style: UIAlertAction.Style.default, handler: { _ in
            AudioPlayer.shared.stopPlayingMusic()
            //self.endTimer()
            //self.pauseTimerOutlet.isUserInteractionEnabled = false

            let viewControllerYouWantToPresent = story.instantiateViewController(withIdentifier: "AddTimeView") as! AddTimeViewController
             UIApplication.shared.keyWindow?.rootViewController?.present(viewControllerYouWantToPresent, animated: true, completion: nil)
            viewControllerYouWantToPresent.task = self.task
        }))
        
        

 

        //Controller.present(alert, animated:true, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated:true, completion: nil)
        
    }
    
    
    func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if(segue.identifier == "toAddNewAlarm") {
            let vc = segue.destination as! AddTimeViewController
            vc.currSeconds = Controllert.totalSeconds
            
        }
    }
    
   


        
        //total seconds, must access data from Core Data (countdownSecond), otherwise it will automatically set the value of label to -1, because rn the totalSeconds var in TableViewController is set to -1)
        //need to make way for int of coredata countdownSecond to be equal to var totalSeconds (reset value of totalSeconds)
        
    
    
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(myTableViewCell.updateTime), userInfo: nil, repeats: true)
        isCounting = true
        
    }
    
    func endTimer() {
        countdownTimer?.invalidate()
        isCounting = false
    }
    


}

