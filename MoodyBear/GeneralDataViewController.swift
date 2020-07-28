//
//  GeneralDataViewController.swift
//  MoodyBear
//
//  Created by Joy Chen on 7/23/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

class GeneralDataViewController: UIViewController {
    
    
    
    
    @IBOutlet var overall: UILabel!
    
    
    @IBOutlet var factors: UILabel!
    
    @IBOutlet var food: UILabel!
    
    
    @IBOutlet var out: UILabel!
    
    @IBOutlet var temp: UILabel!
    
    @IBOutlet var motivation: UILabel!
    
    @IBOutlet var sleep: UILabel!
    @IBOutlet var social: UILabel!
    
    @IBOutlet var relax: UILabel!
    override func viewDidLoad() {
        loadList()
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        
        super.viewDidLoad()
        
    }
    
    @objc func loadList(){
        let words = MoodDatabase.db.selectAllFromDatabase()
        

        
        
        
        
        
        
        
        
        var overallLevel: Int = 0
        var eat1: Int = 0
        var out1: Int = 0
        var temp1: Int = 0
        var social1: Int = 0
        var motivation1: Int = 0
        var sleep1: Int = 0
        var relax1: Int = 0
        for i in 0 ..< words.count {
            overallLevel = words[i].level + overallLevel
            eat1 = words[i].food + eat1
            out1 = words[i].nature + out1
            temp1 = words[i].temperament + temp1
            social1 = words[i].socialization + social1
            motivation1 = words[i].drive + motivation1
            sleep1 = words[i].rest + sleep1
            relax1 = words[i].calm + relax1
            
        }
        let avgMood1 = Double(overallLevel)/Double(words.count)
        let avgMood = round(100 * avgMood1) / 100
        overall.text = "Overall, you have been feeling a mood of \(avgMood) out of 10."
        
        factors.text = "See a breakdown of the factors influencing your mood below."
        
        let eatAvg = Double(eat1)/Double((words.count))
        
        print("eat avg is \(eatAvg)")
        if eatAvg < 1.9 {
            food.text = "You haven't been eating well."
        }
        else if eatAvg < 3.8{
            food.text = "You've been eating okay."
        }
        else {
            food.text = "You've been eating great!"
        }
        
        let outAvg = Double(out1)/Double((words.count))
        
        
        if outAvg < 1.5 {
            out.text = "You haven't been outside much."
        }
        else if outAvg < 3.5{
            out.text = "You've been outside a bit."
        }
        else {
            out.text = "You've been outside a lot!"
        }
        
        
        
        let tempAvg = Double(temp1)/Double((words.count))
        
        
        if tempAvg < 1.5 {
            temp.text = "You've been feeling angry."
        }
        else if tempAvg < 3.5{
            temp.text = "Your temper is ok."
        }
        else {
            temp.text = "You're very calm."
        }
        
        
        let socialAvg = Double(social1)/Double((words.count))
        
        
        if socialAvg < 1.5 {
            social.text = "You haven't been social."
        }
        else if socialAvg < 3.5{
            social.text = "You've been social."
        }
        else {
            social.text = "You've been very social!."
        }
        
        
        let motivationAvg = Double(motivation1)/Double((words.count))
        
        
        if motivationAvg < 1.5 {
            motivation.text = "You haven't been motivated."
        }
        else if motivationAvg < 3.5{
            motivation.text = "You are motivated."
        }
        else {
            motivation.text = "You are very driven!."
        }
        
        
        let sleepAvg = Double(sleep1)/Double((words.count))
        
        
        if sleepAvg < 1.5 {
            sleep.text = "You haven't slept well."
        }
        else if socialAvg < 3.5{
            sleep.text = "You are sleeping okay."
        }
        else {
            sleep.text = "You are getting great sleep!."
        }
        
        let relaxAvg = Double(relax1)/Double((words.count))
        
        
        if relaxAvg < 1.5 {
            relax.text = "You are tense."
        }
        else if relaxAvg < 3.5{
            relax.text = "You are feeling okay."
        }
        else {
            relax.text = "You are relaxed."
        }
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
