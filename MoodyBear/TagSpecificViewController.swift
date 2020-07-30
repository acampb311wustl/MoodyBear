//
//  TagSpecificViewController.swift
//  MoodyBear
//
//  Created by Joy Chen on 7/29/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

class TagSpecificViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tagsArray: [String] = []
    var countArray: [Int] = []
    var moodArray: [Double] = []
    
    @IBOutlet var tableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = "\(tagsArray[indexPath.row]) - Count: \(countArray[indexPath.row]) - Average Mood: \(moodArray[indexPath.row])"
        
        return cell
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        //^^ reuse cell
        tableView.delegate = self
        
        let words = MoodDatabase.db.selectAllFromDatabase()
        
        for i in 1...words.count{
            for temp in MoodDatabase.db.getTagsForMood(moodId: i) {
                print("temp is\(temp)")
                
                if tagsArray.contains(temp.tagName){
                    print("contains")
                    for k in 0 ..< tagsArray.count{
                        if temp.tagName == tagsArray[k]{
                            print("this is the same tag \(temp.tagName)")
                            countArray[k] = countArray[k] + 1
                            moodArray[k] = moodArray[k] + Double(words[i-1].level)
                        }
                    }
                }
                else{
                    print("this is NOT the same tag \(temp.tagName)")
                    tagsArray.append(temp.tagName)
                    countArray.append(1)
                    print(tagsArray)
                    print(countArray)
                    moodArray.append(Double(words[i-1].level))
                }
                
            }

        }
        for i in 0 ..< moodArray.count{
            
            moodArray[i] = moodArray[i] / Double(countArray[i])
            moodArray[i] = round(100 * moodArray[i])/100
            
        }

        
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
