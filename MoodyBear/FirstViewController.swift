//
//  FirstViewController.swift
//  MoodyBear
//
//  Created by Adam Campbell on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadDatabase()
    }
    
    func loadDatabase() {
        let thepath = Bundle.main.path(forResource: "moods", ofType: "db")
        
        let moodDB = FMDatabase(path: thepath)
        
        if !(moodDB.open()) {
            print("unable to open db!")
            return
        }
        else {
            do {
                let results = try moodDB.executeQuery("select * from moodHistory", values: nil)
                
                while (results.next()) {
                    let someMood = results.string(forColumn: "description")
                    print(someMood)
                }
            } catch let error as NSError {
                print("db error \(error)")
            }
        }
    }


}

