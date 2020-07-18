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
    
    var moodDB : FMDatabase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        loadDatabase()
    }
    
    func loadDatabase() {
        let thepath = Bundle.main.path(forResource: "moods", ofType: "db")
        
        moodDB = FMDatabase(path: thepath)
        
        if !(moodDB.open()) {
            print("unable to open db!")
            return
        }
    }
    @IBAction func submitButtonAction(_ sender: Any) {

//        do {
//            let query = "insert into moodHistory (level,description) values (3,'\(moodDetailsField.text ?? "")')"
//            try moodDB.executeUpdate(query, values:nil)
//
////            insert into moodHistory (level,description) values (1, 'not feeling so great :(');
//
//        } catch let error as NSError {
//            print("db error \(error)")
//        }
    }
    
    @IBAction func clearButtonAction(_ sender: Any) {
//        do {
//            let results = try moodDB.executeQuery("select * from moodHistory", values: nil)
//
//            while (results.next()) {
//                let someMood = results.string(forColumn: "description") ?? ""
//                print(String(someMood))
//            }
//        } catch let error as NSError {
//            print("db error \(error)")
//        }
    }
    
}

