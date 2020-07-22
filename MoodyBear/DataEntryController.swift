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
    
      //graphing categories- eating, outside, temperament, social, motivation, sleep, relaxation
    
    var eat = 0
    var out = 0
    var temp = 0
    var social = 0
    var motivation = 0
    var sleep = 0
    var relax = 0
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var completedQuestionaireLabel: UILabel!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var questionStack: UIStackView!
    var tagList: [String] = []
    
    @IBAction func buttonClick(_ sender: AnyObject) {
        //Check the users input
//        var yes = 0
//        var lyes = 0
//        var middle = 0
//        var lno = 0
//        var no = 0
        print(currentQuestion)
        //current question is 1 ahead so it accounts for the previous one?
        if currentQuestion == 1{
            //eat
            eat = sender.tag
            print("eat is changed")
        }
        if currentQuestion == 2{
              //out
            out = sender.tag
          }
        if currentQuestion == 3{
              //temp
            temp = sender.tag
          }
        if currentQuestion == 4{
              //social
                social = sender.tag
          }
        if currentQuestion == 5{
              //motivation
                motivation = sender.tag
          }
        if currentQuestion == 6{
              //sleep
                sleep = sender.tag
          }
        if currentQuestion == 7{
              //relax
                relax = sender.tag
          }
//        if(sender.tag == 5)
//        {
//            yes += 1
//            print("yes")
//        }
//
//        if(sender.tag == 4)
//        {
//            lyes += 1
//            print("a little")
//        }
//
//        if(sender.tag == 3)
//        {
//            middle += 1
//            print("not sure")
//        }
//
//        if(sender.tag == 2)
//        {
//            lno += 1
//            print("not really")
//        }
//
//        if(sender.tag == 1)
//        {
//            no += 1
//            print("no")
//        }
        
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
            tagList.append(tempText)
            print(tagList)
        }
        newTagTextField.text = ""
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        let tempNum = Int(moodLevelSlider.value)
        let tempDetails = moodDetailsField.text ?? ""
        
        MoodDatabase.db.insertIntoDatabase(level: tempNum, description: tempDetails, food: eat, nature: out, temperament: temp, socialization: social, drive: motivation, rest: sleep, calm: relax )
        print(MoodDatabase.db)
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
        
        print("title is \(title)")
        let length = tagList.count
        print("length is \(length)")
        var removeInt = 0
        for i in 0..<length {
            print(i)
            print("tag list at this point is \(tagList[i])")
            if tagList[i].contains(title){
                print("title removed is \(title) at \(i)")
                removeInt = i
            }
        }
        tagList.remove(at: removeInt)
        tagListView.removeTag(title) // all tags with title “meow” will be removed
    }
    
    //Questions and Answers for Questionaire
    //<<<<<<< HEAD
    let questions = ["I ate well today", "I spent enough time outside today", "If my food order was missing items, I would not be angry", "I spent time being social today","I feel motivated","I got enough sleep last night","I feel relaxed and not stressed"]
    //graphing categories- eating, outside, temperament, social, motivation, sleep, relaxation
    let answers = ["Definitely", "somewhat agree", "not sure", "not really", "No way"]
    //=======
    //    let questions = ["I am content right now?", "I spent enough time outside today?", "If my food order was missing items, I would be angry", "I am not having postive thoughts right now","I feel motivated","I am enthusiastic right now","I feel overwhelmed"]
    ////    let answers = [["Definitely", "somewhat agree", "not sure", "not really", "No way"]]
    //        let answers = [["YES!", "sure", "IDK", "not really", "NO!"]]
    ////>>>>>>> 978fd192be65d4e849165d6c2099378323fa5371
    ////
    var currentQuestion = 0
    
    
    //Displays next question
    func newQuestion(){
        questionLabel.text = questions[currentQuestion]
        
        for buttonTag in 1...5{
            if(buttonTag == 5){
                //We can change the answer to every question if we add it to the array and do the following line instead
                // button.setTitle(answers[currentQuestion][0], for: .normal)
                btn5.setTitle(answers[0], for: .normal)
            }
            if(buttonTag == 4){
                
                btn4.setTitle(answers[1], for: .normal)
            }
            if(buttonTag == 3){
                
                btn3.setTitle(answers[2], for: .normal)
            }
            if(buttonTag == 2){
                
                btn2.setTitle(answers[3], for: .normal)
            }
            if(buttonTag == 1){
                
                btn1.setTitle(answers[4], for: .normal)
            }
        }
        currentQuestion += 1
    }
    
}


