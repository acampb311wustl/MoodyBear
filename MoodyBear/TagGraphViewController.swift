//
//  TagGraphViewController.swift
//  MoodyBear
//
//  Created by Joy Chen on 7/25/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit
import Charts

class TagGraphViewController: UIViewController {
    @IBOutlet var selector: UISegmentedControl!
    var tagsArray: [String] = []
    var countArray: [Int] = []
    @IBOutlet var frequencyChart: BarChartView!
    var barArray:[BarChartDataEntry] = []
    var index = 0
    
//    @IBAction func button(_ sender: Any) {
//        let detailVC = TagSpecificViewController()
//        
//        self.present(detailVC, animated: true, completion: nil)
//    }
    @IBAction func selectTag(_ sender: Any) {
        if selector.selectedSegmentIndex == 0{
            index = 0
            frequencyChartUpdate()
            
        }
        else {
            index = 1
            frequencyChartUpdate()
        }
        
        
    }
    //    @IBAction func selectOne(_ sender: Any) {
    //        if selector.selectedSegmentIndex == 0{
    //            index = 0
    //            frequencyChartUpdate()
    //
    //        }
    ////        else {
    ////            index = 1
    ////            frequencyChartUpdate()
    ////        }
    //
    //    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        frequencyChartUpdate()
        
    }
    
    
    
    func frequencyChartUpdate () {
        let words = MoodDatabase.db.selectAllFromDatabase()
        tagsArray = []
        countArray = []
        barArray = []
        if index == 1 && words.count>3 {
            for i in (words.count-2)...words.count{
                for temp in MoodDatabase.db.getTagsForMood(moodId: i) {
                    print("temp is\(temp)")
                    if tagsArray.contains(temp.tagName){
                        print("contains")
                        for i in 0 ..< tagsArray.count{
                            if temp.tagName == tagsArray[i]{
                                print("this is the same tag \(temp.tagName)")
                                countArray[i] = countArray[i] + 1
                            }
                        }
                    }
                    else{
                        print("this is NOT the same tag \(temp.tagName)")
                        tagsArray.append(temp.tagName)
                        countArray.append(1)
                        print(tagsArray)
                        print(countArray)
                    }
                    
                }
                print(tagsArray)
                print(countArray)
            }
            //        for i in 0..<countArray.count{
            //              countArray[i] = countArray[i]/2
            //          }
            //        if index == 0{
            //            print("index is 0")
            //            for i in 0 ..< countArray.count{
            //                barArray.append(BarChartDataEntry(x: Double(i), y:Double(countArray[i])))
            //                print(barArray)
            //                frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: tagsArray)
            //                       frequencyChart.xAxis.labelCount = tagsArray.count
            //            }
            //        }
            //        else{
            //            print("index is 1")
            //            var array: [String] = []
            //            if countArray.count > 3 {
            //                for i in 0 ..< 3{
            //                    barArray = []
            //                    barArray.append(BarChartDataEntry(x: Double(i), y:Double(countArray[i])))
            //                    print(barArray)
            //                    array.append(tagsArray[i])
            //                    frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: array)
            //                           frequencyChart.xAxis.labelCount = 3
            //                }
            //            }
            //            else{
            //                for i in 0 ..< countArray.count{
            //                    barArray = []
            //                    barArray.append(BarChartDataEntry(x: Double(i), y:Double(countArray[i])))
            //                    print(barArray)
            //                    frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: tagsArray)
            //                           frequencyChart.xAxis.labelCount = tagsArray.count
            //                }
            //            }
            //        }
            
            
            for i in 0 ..< countArray.count{
                barArray.append(BarChartDataEntry(x: Double(i), y:Double(countArray[i])))
                print(barArray)
                frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: tagsArray)
                frequencyChart.xAxis.labelCount = tagsArray.count
            }
            frequencyChart.xAxis.drawGridLinesEnabled = false
            frequencyChart.xAxis.labelPosition = .bottom
            
            //        frequencyChart.xAxis.granularity = 2
            frequencyChart.leftAxis.enabled = true
            //        frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:tagsArray)
            let dataSet = BarChartDataSet(entries: barArray, label: "Tags")
            //                  //filler data for bar chart until I get  tags to work with
            //                  dataSet.colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.systemPink, UIColor.purple, UIColor.yellow, UIColor.orange]
            let data = BarChartData(dataSets: [dataSet])
            frequencyChart.data = data
            //          //        print("this is frequency chart \(frequencyChart)")
            //                  frequencyChart.chartDescription?.text = "Mood Factors"
            //
            //                  //All other additions to this function will go here
            //
            //                  //This must stay at end of function
            //
            frequencyChart.notifyDataSetChanged()
            
        }
        else{
            for i in 1...words.count{

                for temp in MoodDatabase.db.getTagsForMood(moodId: i) {
                    print("temp is\(temp)")
                    if tagsArray.contains(temp.tagName){
                        print("contains")
                        for i in 0 ..< tagsArray.count{
                            if temp.tagName == tagsArray[i]{
                                print("this is the same tag \(temp.tagName)")
                                countArray[i] = countArray[i] + 1
                            }
                        }
                    }
                    else{
                        print("this is NOT the same tag \(temp.tagName)")
                        tagsArray.append(temp.tagName)
                        countArray.append(1)
                        print(tagsArray)
                        print(countArray)
                    }
                    
                }
                print(tagsArray)
                print(countArray)
            }
            //        for i in 0..<countArray.count{
            //              countArray[i] = countArray[i]/2
            //          }
            //        if index == 0{
            //            print("index is 0")
            //            for i in 0 ..< countArray.count{
            //                barArray.append(BarChartDataEntry(x: Double(i), y:Double(countArray[i])))
            //                print(barArray)
            //                frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: tagsArray)
            //                       frequencyChart.xAxis.labelCount = tagsArray.count
            //            }
            //        }
            //        else{
            //            print("index is 1")
            //            var array: [String] = []
            //            if countArray.count > 3 {
            //                for i in 0 ..< 3{
            //                    barArray = []
            //                    barArray.append(BarChartDataEntry(x: Double(i), y:Double(countArray[i])))
            //                    print(barArray)
            //                    array.append(tagsArray[i])
            //                    frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: array)
            //                           frequencyChart.xAxis.labelCount = 3
            //                }
            //            }
            //            else{
            //                for i in 0 ..< countArray.count{
            //                    barArray = []
            //                    barArray.append(BarChartDataEntry(x: Double(i), y:Double(countArray[i])))
            //                    print(barArray)
            //                    frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: tagsArray)
            //                           frequencyChart.xAxis.labelCount = tagsArray.count
            //                }
            //            }
            //        }
            
            
            for i in 0 ..< countArray.count{
                barArray.append(BarChartDataEntry(x: Double(i), y:Double(countArray[i])))
                print(barArray)
                frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: tagsArray)
                frequencyChart.xAxis.labelCount = tagsArray.count
            }
            frequencyChart.xAxis.drawGridLinesEnabled = false
            frequencyChart.xAxis.labelPosition = .bottom
            
            //        frequencyChart.xAxis.granularity = 2
            frequencyChart.leftAxis.enabled = true
            //        frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:tagsArray)
            let dataSet = BarChartDataSet(entries: barArray, label: "Tags")
            //                  //filler data for bar chart until I get  tags to work with
            //                  dataSet.colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.systemPink, UIColor.purple, UIColor.yellow, UIColor.orange]
            let data = BarChartData(dataSets: [dataSet])
            frequencyChart.data = data
            //          //        print("this is frequency chart \(frequencyChart)")
            //                  frequencyChart.chartDescription?.text = "Mood Factors"
            //
            //                  //All other additions to this function will go here
            //
            //                  //This must stay at end of function
            //
            frequencyChart.notifyDataSetChanged()
        }
    }
    
    
    
    
    //    func pieChartUpdate () {
    //        let entry1 = PieChartDataEntry(value: 4, label: "#1")
    //        let entry2 = PieChartDataEntry(value: 2, label: "#2")
    //        let entry3 = PieChartDataEntry(value: 9, label: "#3")
    //        let dataSet = PieChartDataSet(entries: [entry1, entry2, entry3], label: "Widget Types")
    //        let data = PieChartData(dataSet: dataSet)
    //        pieChart.data = data
    //        pieChart.chartDescription?.text = "Share of Widgets by Type"
    //
    //        //All other additions to this function will go here
    ////        print("this is pie chart \(pieChart)")
    //        //This must stay at end of function
    //        pieChart.notifyDataSetChanged()
    //    }
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //                lineChartUpdate()
        frequencyChartUpdate()
        //                          pieChartUpdate()
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
