//
//  FirstViewController.swift
//  MoodyBear
//
//  Created by Team Moody Bear on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

class DataEntryController: UIViewController {
    @IBOutlet weak var moodLevelSlider: UISlider!
    @IBOutlet weak var moodDetailsField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let tempNum = Int(moodLevelSlider.value)
        let tempDetails = moodDetailsField.text ?? ""
        
        MoodDatabase.db.insertIntoDatabase(level: tempNum, description: tempDetails)
    }
    
    @IBAction func clearButtonAction(_ sender: Any) {
        let asdf = MoodDatabase.db.selectAllFromDatabase()
        for temp in asdf {
            print(temp.description)
        }
    }
    
}

