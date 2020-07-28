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
    weak var delegate: EditViewDelegate!
    
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
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        let tempNum = Int(moodLevelSlider.value)
        let tempDetails = moodDetailTextView.text ?? ""
        MoodDatabase.db.updateMood(level: tempNum, description: tempDetails, moodId: mood.id)
        MoodDatabase.db.deleteTagsForMood(moodId: mood.id)
        MoodDatabase.db.insertTagsForMood(tags: tagListView.getTagNames(), moodId: mood.id)
        delegate?.doneEditing()
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title) // all tags with title will be removed
    }
}

protocol EditViewDelegate: class {
    func doneEditing()
}
