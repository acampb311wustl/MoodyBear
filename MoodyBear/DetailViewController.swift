//
//  DetailViewController.swift
//  MoodyBear
//
//  Created by Adam Campbell on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "theCell")
        detailTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoodDatabase.db.getNumRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "theCell")! as UITableViewCell
        let myArray = MoodDatabase.db.selectAllFromDatabase()
        myCell.textLabel!.text = myArray[indexPath.row].description
        
        return myCell
    }

}
