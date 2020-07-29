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
    var tagsArray: [String] = []
    var countArray: [Int] = []
    @IBOutlet var frequencyChart: BarChartView!
    var barArray:[BarChartDataEntry] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //        let theFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        //        let scrollView = UIScrollView(frame: theFrame)
        //        //        scrollView.backgroundColor = UIColor.gray
        //        view.addSubview(scrollView)
        //        let theGraphFrame = CGRect(x: 3, y: 0, width: self.view.frame.size.width-6, height: 250)
        //        lineChart = LineChartView(frame: theGraphFrame)
        
        // Do any additional setup after loading the view.
        //        lineChartUpdate()
        frequencyChartUpdate()
        //        pieChartUpdate()
    }
    
    //    func lineChartUpdate () {
    //        let currentLevels = MoodDatabase.db.selectAllFromDatabase()
    //
    //        // 1 - creating an array of data entries
    //        var yValues : [ChartDataEntry] = [ChartDataEntry]()
    //        print("yvalues are \(yValues)")
    //        for i in 0 ..< currentLevels.count {
    //            yValues.append(ChartDataEntry(x: Double(i + 1), y: Double(currentLevels[i].level)))
    //        }
    //
    //        let data = LineChartData()
    //        let ds = LineChartDataSet(entries: yValues)
    //        data.addDataSet(ds)
    //        lineChart.data = data
    ////        print("this is line chart \(lineChart)")
    //        //This must stay at end of function
    //        lineChart.notifyDataSetChanged()
    //    }
    
    func frequencyChartUpdate () {
        let words = MoodDatabase.db.selectAllFromDatabase()
        
        tagsArray = []
        countArray = []
        
        barArray = []
        
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
                
                
                
                
                //                for item in tagsArray{
                //                    if temp.tagName == item{
                //                        print("this is the same tag \(temp.tagName)")
                //                        let u = index(ofAccessibilityElement: item)
                //                        countArray[u] = countArray[u] + 1
                //                    }
                //                    else{
                //                                  print("this is NOT the same tag \(temp.tagName)")
                //                        tagsArray.append(temp.tagName)
                //                        countArray.append(1)
                //                    }
                //                }
            }
            print(tagsArray)
            print(countArray)
        }
        //        for i in 0..<countArray.count{
        //              countArray[i] = countArray[i]/2
        //          }
        for i in 0 ..< countArray.count{
            barArray.append(BarChartDataEntry(x: Double(i), y:Double(countArray[i])))
            print(barArray)
        }
        
        
        //        let entry1 = BarChartDataEntry(x: 1.0, y: 7.0)
        //                  let entry2 = BarChartDataEntry(x: 2.0, y: Double(out))
        //                  let entry3 = BarChartDataEntry(x: 3.0, y: Double(temp))
        //                  let entry4 = BarChartDataEntry(x: 4.0, y: Double(social))
        //                  let entry5 = BarChartDataEntry(x: 5.0, y: Double(motivation))
        //                  let entry6 = BarChartDataEntry(x: 6.0, y: Double(sleep))
        //                  let entry7 = BarChartDataEntry(x: 7.0, y: Double(relax))
        //                  let labels = ["Food", "Outside", "Temperament", "Social", "Motivation", "Sleep", "Relaxation"]
        //
            frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: tagsArray)
//        frequencyChart.xAxis.granularityEnabled = true
//        pieChart.legend.font = UIFont(name: "Futura", size: 10)!
//        frequencyChart.legend.entries = tagsArray
        frequencyChart.xAxis.drawGridLinesEnabled = false
        frequencyChart.xAxis.labelPosition = .bottom
        frequencyChart.xAxis.labelCount = tagsArray.count
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
        //                  frequencyChart.notifyDataSetChanged()
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
