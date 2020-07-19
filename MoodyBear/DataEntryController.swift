//
//  FirstViewController.swift
//  MoodyBear
//
//  Created by Team Moody Bear on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit
//import TagListView

class DataEntryController: UIViewController, TagListViewDelegate {
    @IBOutlet weak var moodLevelSlider: UISlider!
    @IBOutlet weak var moodDetailsField: UITextView!
    @IBOutlet weak var tagListView: TagListView!
    
    @IBOutlet weak var newTagTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.delegate = self

        
        tagListView.textFont = UIFont.systemFont(ofSize: 18)
        tagListView.alignment = .left
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        tagListView.addTag(formatter.string(from: date))
    }
    
    @IBAction func newTagAddButton(_ sender: Any) {
        if let tempText = newTagTextField.text
        {
            tagListView.addTag(tempText)
        }
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let tempNum = Int(moodLevelSlider.value)
        let tempDetails = moodDetailsField.text ?? ""
        
        MoodDatabase.db.insertIntoDatabase(level: tempNum, description: tempDetails)
    }
    
    @IBAction func clearButtonAction(_ sender: Any) {
        for temp in MoodDatabase.db.selectAllFromDatabase() {
            print(temp.description)
        }
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        //print("Tag pressed: \(title), \(sender)")
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title) // all tags with title “meow” will be removed
    }
    
}

