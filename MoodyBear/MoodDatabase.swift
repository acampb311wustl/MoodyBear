//
//  MoodDatabase.swift
//  MoodyBear
//
//  Created by Team Moody Bear on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

struct Mood {
    let description : String
    let level : Int
}

class MoodDatabase {
    var moodDB : FMDatabase!
    
    static let db = MoodDatabase()
    
    private init() {
        loadDatabase()
    }
    
    func insertIntoDatabase(level: Int, description: String) {
        let query = "insert into moodHistory (level,description) values (\(level),\'\(description)\')"
        
        do {
            try moodDB.executeUpdate(query, values:nil)
            
        } catch let error as NSError {
            print("db error \(error)")
        }
    }
    
    func loadDatabase() {
        let thepath = Bundle.main.path(forResource: "moods", ofType: "db")
        
        moodDB = FMDatabase(path: thepath)
        
        if !(moodDB.open()) {
            print("unable to open db!")
            return
        }
    }
    
    func selectAllFromDatabase() -> [Mood] {
        var tempMoods : [Mood] = []
        do {
            let results = try moodDB.executeQuery("select * from moodHistory", values: nil)
            
            while (results.next()) {
                tempMoods.append(Mood(description: results.string(forColumn: "description") ?? "", level: Int(results.int(forColumn: "level") )))
            }
        } catch let error as NSError {
            print("db error \(error)")
        }
        
        return tempMoods
    }
    
    func getNumRows() -> Int {
        do {
            let results = try moodDB.executeQuery("SELECT COUNT(*) FROM moodHistory", values: nil)
            
            while (results.next()) {
                print(results)
                return Int(results.int(forColumn: "Count"))
            }
        } catch let error as NSError {
            print("db error \(error)")
        }
        
        return 0
    }
}
