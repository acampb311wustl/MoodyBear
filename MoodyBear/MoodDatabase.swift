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

func getTagFromQueryResults(queryResult: FMResultSet) -> Tag {
    var tempTag : Tag = Tag(tagName: "", moodId: 0)
    tempTag.tagName = queryResult.string(forColumn: "tagName") ?? ""
    tempTag.moodId = Int(queryResult.int(forColumn: "moodId"))
    
    return tempTag
}


class MoodDatabase {
    var moodDB : FMDatabase!
    
    /// A static instance of the db that is the publicly facing access point. This reduces the need for multiple connections. There is a single open connection at the beginning of the run
    static let db = MoodDatabase()
    
    
    /// the init function is only called once; the first time the static variable is accessed.
    private init() {
        loadDatabase()
        configureDatabase()
    }
    
    /// Insert a mood given its pieces into a database
    /// - Parameters:
    ///   - level: level
    ///   - description: description
    ///   - food: food
    ///   - nature: nature
    ///   - temperament: temperament
    ///   - socialization: socialization
    ///   - drive: drive
    ///   - rest: rest
    ///   - calm: calm
    func insertIntoDatabase(level: Int, description: String, food: Int, nature: Int, temperament: Int, socialization: Int, drive: Int, rest: Int, calm: Int){
        let query = "INSERT INTO moodHistory (level,description, food, nature, temperament, socialization, drive, rest, calm) VALUES (?,?,?,?,?, ?,?,?,?)"
        
        do {
            try moodDB.executeUpdate(query, values:[level, description, food, nature, temperament, socialization, drive, rest, calm])
            
        } catch let error as NSError {
            print("db error \(error)")
        }
    }
    
    /// Delete a mood given its id. I use this to delete a mood from the detail table view
    /// - Parameter id: the id of the mood to delete
    func deleteWithId(id: Int) {
        let query = "DELETE FROM moodHistory WHERE id=?"
        
        do {
            try moodDB.executeUpdate(query, values:[id])
            
        } catch let error as NSError {
            print("db error \(error)")
        }
    }
    
    /// Connect to the sqlite database!
    func loadDatabase() {
        let thepath = Bundle.main.path(forResource: "moods", ofType: "db")
        
        moodDB = FMDatabase(path: thepath)
        
        if !(moodDB.open()) {
            print("Unable to open db!")
            return
        }
    }
    
    /// Perform any database init commands. We need to inform the sqlite db to use foreign keys so that we can match up the mood tags with their mood
    func configureDatabase() {
        do {
            try moodDB.executeQuery("PRAGMA foreign_keys = ON", values: nil)
        } catch {
            print("Error turning foreign keys on: \(error)")
        }
    }
    
    /// Get all of the moods present in the moodHistory table. This is useful in order to give the view controller something to display in the table view
    /// - Returns: An array of Mood
    func selectAllFromDatabase() -> [Mood] {
        var tempMoods : [Mood] = []
        do {
            let results = try moodDB.executeQuery("SELECT * FROM moodHistory", values: nil)
            
            while (results.next()) {
                tempMoods.append(getMoodFromQueryResults(queryResult: results))
            }
        } catch let error as NSError {
            print("Error getting moods: \(error)")
        }
        
        return tempMoods
    }
    
    /// Get the total number of moods present in the moodHistory table. This is useful for things like the detail view so we can inform the controller how many items there will be in the table.
    /// - Returns: the number of moods
    func getNumMoods() -> Int {
        do {
            let results = try moodDB.executeQuery("SELECT COUNT(*) as Count FROM moodHistory", values: nil)
            
            while (results.next()) {
                
                return Int(results.int(forColumn: "Count"))
            }
        } catch let error as NSError {
            print("Error getting number of moods: \(error)")
        }
        
        return 0
    }
    
    /// Get the id of the row that was just inserted into the database. Use this carefully as other entities interacting with the DB could cause this to return something you don't expect. I plan to use this to get the Id of the mood that inserted immediately before this call.
    /// - Returns: the autogenerated ID from sqlite that matches the row that was just inserted
    func getIdOfLastRow() -> Int {
        do {
            let results = try moodDB.executeQuery("SELECT LAST_INSERT_ROWID() as id", values: nil)
            
            while (results.next()) {
                return Int(results.int(forColumn: "id"))
            }
        } catch let error as NSError {
            print("Error getting last row id: \(error)")
        }
        
        return 0
    }
    
    /// Get all the tags associated with a given mood id. Most likely called like getTagsForMood(mood.id)
    /// - Parameter moodId: the mood id of interest
    /// - Returns: an array of Tag objects
    func getTagsForMood(moodId: Int) -> [Tag] {
        var tempTags : [Tag] = []
        do {
            let results = try moodDB.executeQuery("SELECT * FROM moodTags WHERE moodId=?", values: [moodId])
            
            while (results.next()) {
                tempTags.append(getTagFromQueryResults(queryResult: results))
            }
        } catch let error as NSError {
            print("Error getting tags: \(error)")
        }
        
        return tempTags
    }
    
    /// Inserts a series of given tagview objects into a table that relates them to a given mood.
    /// - Parameters:
    ///   - tags: an array of TagView objects
    ///   - moodId: the id of the mood that corresponds to these tags.
    func insertTagsForMood(tags: [String], moodId: Int) {
        tags.forEach { tag in
            let query = "INSERT INTO moodTags (tagName, moodId) VALUES (?,?)"
            
            do {
                try moodDB.executeUpdate(query, values:[tag, moodId])
                
            } catch let error as NSError {
                print("Error inserting tags: \(error)")
            }
        }
    }
}
