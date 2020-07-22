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
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var completedQuestionaireLabel: UILabel!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var questionStack: UIStackView!
    @IBAction func buttonClick(_ sender: AnyObject) {
        //Check the users input
        var yes = 0
        var lyes = 0
        var middle = 0
        var lno = 0
        var no = 0
        
        if(sender.tag == 5)
        {
            yes += 1
            print("yes")
        }
        
        if(sender.tag == 4)
        {
            lyes += 1
            print("a little")
        }
        
        if(sender.tag == 3)
        {
            middle += 1
            print("not sure")
        }
        
        if(sender.tag == 2)
        {
            lno += 1
            print("not really")
        }

        if(sender.tag == 1)
        {
            no += 1
            print("no")
        }
        
        if(currentQuestion != questions.count)
        {
            newQuestion()
        }
        else{
            buttonStack.removeFromSuperview()
            
            questionLabel.text = "Question are Complete :)"
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.delegate = self
        newQuestion()
        
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
    
    //Questions and Answers for Questionaire
    let questions = ["I am content right now?", "I spent enough time outside today?", "If my food order was missing items, I would be angry", "I am not having postive thoughts right now","I feel motivated","I am enthusiastic right now","I feel overwhelmed"]
//    let answers = [["Definitely", "somewhat agree", "not sure", "not really", "No way"]]
        let answers = [["YES!", "sure", "IDK", "not really", "NO!"]]
    
    var currentQuestion = 0
    
    
    //Displays next question
    func newQuestion(){
        questionLabel.text = questions[currentQuestion]
        
        for buttonTag in 1...5{
            if(buttonTag == 5){
            //We can change the answer to every question if we add it to the array and do the following line instead
            // button.setTitle(answers[currentQuestion][0], for: .normal)
                btn5.setTitle(answers[0][0], for: .normal)
            }
            if(buttonTag == 4){
                
                btn4.setTitle(answers[0][1], for: .normal)
            }
            if(buttonTag == 3){
                
                 btn3.setTitle(answers[0][2], for: .normal)
            }
            if(buttonTag == 2){
                
                 btn2.setTitle(answers[0][3], for: .normal)
            }
            if(buttonTag == 1){
                
                 btn1.setTitle(answers[0][4], for: .normal)
            }
        }
         currentQuestion += 1
    }
    
}


