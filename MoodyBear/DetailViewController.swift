//
//  DetailViewController.swift
//  MoodyBear
//
//  Created by Adam Campbell on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var detailTableView: UITableView!
    
    var dataCache : [Mood] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "theCell")
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var asdf = MoodDatabase.db.getTagsForMood(moodId:dataCache[indexPath.row].id)
        for temp in asdf {
            print(temp.tagName)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoodDatabase.db.getNumMoods()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "theCell")! as UITableViewCell
        dataCache = MoodDatabase.db.selectAllFromDatabase()
        myCell.textLabel!.text = dataCache[indexPath.row].description
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            MoodDatabase.db.deleteWithId(id: dataCache[indexPath.row].id)
            dataCache = MoodDatabase.db.selectAllFromDatabase()
            detailTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailTableView.reloadData()
    }
}
