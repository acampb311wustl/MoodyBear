//
//  EditViewController.swift
//  MoodyBear
//
//  Created by Adam Campbell on 7/24/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, TagListViewDelegate {
    var mood : Mood!
    
    @IBOutlet weak var moodLevelSlider: UISlider!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var moodDetailTextView: UITextView!
    @IBOutlet weak var tagTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagListView.delegate = self
        
        //fill out the tabs from the db
        for temp in MoodDatabase.db.getTagsForMood(moodId: mood.id) {
            tagListView.addTag(temp.tagName)
        }
        
        moodLevelSlider.value = Float(mood.level)
        moodDetailTextView.text = mood.description
        
    }
    @IBAction func addTagButton(_ sender: Any) {
        if let tempText = tagTextField.text
        {
            tagListView.addTag(tempText)
        }
        tagTextField.text = ""
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title) // all tags with title will be removed
    }
}
