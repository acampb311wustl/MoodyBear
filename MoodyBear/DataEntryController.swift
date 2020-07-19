//
//  FirstViewController.swift
//  MoodyBear
//
//  Created by Team Moody Bear on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit
//import TagListView

class DataEntryController: UIViewController {
    @IBOutlet weak var moodLevelSlider: UISlider!
    @IBOutlet weak var moodDetailsField: UITextView!
    @IBOutlet weak var tagListView: TagListView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.textFont = UIFont.systemFont(ofSize: 24)
        tagListView.alignment = .center // possible values are [.leading, .trailing, .left, .center, .right]

        tagListView.addTag("TagListView")
        tagListView.addTags(["Add", "two", "tags"])


        //tagListView.setTitle("New Title", at: 6) // to replace the title a tag

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

