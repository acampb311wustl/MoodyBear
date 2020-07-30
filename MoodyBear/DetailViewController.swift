//
//  DetailViewController.swift
//  MoodyBear
//
//  Created by Adam Campbell on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EditViewDelegate {

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
        let editView = EditViewController.initFromNib()
        editView.mood = dataCache[indexPath.row]
        editView.delegate = self
        self.present(editView, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoodDatabase.db.getNumMoods()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "theCell")! as UITableViewCell
        dataCache = MoodDatabase.db.selectAllFromDatabase()
        myCell.textLabel!.text = dataCache[indexPath.row].description
            myCell.backgroundColor = UIColor.systemTeal
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
    
    func doneEditing() {
        dismiss(animated: true, completion: {
            self.detailTableView.reloadData()
        })
    }
  
}

//https://stackoverflow.com/questions/27099054/load-uiviewcontroller-from-the-separate-nib-file-in-swift
extension UIViewController {
    static func initFromNib() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)
        }
        return instanceFromNib()
    }
}

