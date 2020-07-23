//
//  MoodDatabase.swift
//  MoodyBear
//
//  Created by Team Moody Bear on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

struct Mood {
    var description : String
    var level : Int
    var food: Int
    var nature: Int
    var temperament: Int
    var socialization: Int
    var drive: Int
    var rest: Int
    var calm: Int
    var id : Int
}

struct Tag {
    var tagName : String
    var moodId : Int
}

func getMoodFromQueryResults(queryResult: FMResultSet) -> Mood {
    var tempMood : Mood = Mood(description: "",level: 0, food:0, nature: 0, temperament:0, socialization: 0, drive:0, rest:0, calm:0, id:0)
    tempMood.description = queryResult.string(forColumn: "description") ?? ""
    tempMood.level = Int(queryResult.int(forColumn: "level"))
    tempMood.id = Int(queryResult.int(forColumn: "id"))
    tempMood.food = Int(queryResult.int(forColumn: "food"))
    tempMood.nature = Int(queryResult.int(forColumn: "nature"))
    tempMood.temperament = Int(queryResult.int(forColumn: "temperament"))
    tempMood.socialization = Int(queryResult.int(forColumn: "socialization"))
    tempMood.drive = Int(queryResult.int(forColumn: "drive"))
    tempMood.rest = Int(queryResult.int(forColumn: "rest"))
    tempMood.calm = Int(queryResult.int(forColumn: "calm"))
    return tempMood
}

class MoodDatabase {
    var moodDB : FMDatabase!
    
    static let db = MoodDatabase()
    
    private init() {
        loadDatabase()
    }
    
    func insertIntoDatabase(level: Int, description: String, food: Int, nature: Int, temperament: Int, socialization: Int, drive: Int, rest: Int, calm: Int) {
        let query = "insert into moodHistory (level,description, food, nature, temperament, socialization, drive, rest, calm) values (\(level),\'\(description)\', \(food), \(nature), \(temperament), \(socialization), \(drive), \(rest), \(calm))"

        do {
            try moodDB.executeUpdate(query, values:nil)
            
        } catch let error as NSError {
            print("db error \(error)")
        }
    }
    
    func deleteWithId(id: Int) {
        let query = "DELETE FROM moodHistory WHERE id=\(id)"
        
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
                tempMoods.append(getMoodFromQueryResults(queryResult: results))
            }
        } catch let error as NSError {
            print("db error \(error)")
        }
        
        return tempMoods
    }
    
    func getNumRows() -> Int {
        do {
            let results = try moodDB.executeQuery("SELECT COUNT(*) as Count FROM moodHistory", values: nil)
            
            while (results.next()) {

                return Int(results.int(forColumn: "Count"))
            }
        } catch let error as NSError {
            print("db error \(error)")
        }
        
        return 0
    }
}
