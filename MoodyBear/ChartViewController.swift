//
//  SecondViewController.swift
//  MoodyBear
//
//  Created by Team Moody Bear on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController  {
    //    @IBOutlet weak var number1: UISlider!
    //    @IBOutlet weak var number2: UISlider!
    //    @IBOutlet weak var number3: UISlider!
    var eatArray: [Int] = []
    var outArray: [Int] = []
    var tempArray: [Int] = []
    var socialArray: [Int] = []
    var motivationArray: [Int] = []
    var sleepArray: [Int] = []
    var relaxArray: [Int] = []
    //    var lineChart: LineChartView!
    //    @IBOutlet var lineChart: LineChartView!
    //    var barChart: LineChartView!
    @IBOutlet var label: UILabel!
    
    //    @IBOutlet var pieChart: LineChartView!
    //    @IBOutlet var frequencyChart: LineChartView!
    
    
    //    @IBOutlet var lineChart: LineChartView!
    
    //    @IBOutlet var frequencyChart: BarChartView!
    
    @IBOutlet var lineChart: LineChartView!
    var recentAvg = 0.0
    
    //    @IBOutlet var lineChart: LineChartView!
    //
    //    @IBOutlet var frequencyChart: BarChartView!
    //TODO once getting real data:
    
    // make scroll view and append graphs
    // make weekly / total graphs
    // create histogram of tagged values
    // add pie chart for tagged values
    //after figuring out color theme, update graphs aesthetic accordingly
    //maybe: add graph summaries?
    //    var barChart: LineChartView!
    //    @IBOutlet weak var frequencyChart: BarChartView!
    //    @IBOutlet weak var pieChart: PieChartView!
    //    @IBAction func renderCharts() {
    //        barChartUpdate()
    //        frequencyChartUpdate()
    //        pieChartUpdate()
    //    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //        let theFrame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        //        let scrollView = UIScrollView(frame: theFrame)
        //        //        scrollView.backgroundColor = UIColor.gray
        //        view.addSubview(scrollView)
        //        let theGraphFrame = CGRect(x: 3, y: 0, width: self.view.frame.size.width-6, height: 250)
        //        lineChart = LineChartView(frame: theGraphFrame)
        
        // Do any additional setup after loading the view.
        lineChartUpdate()
        //        frequencyChartUpdate()
        //        pieChartUpdate()
    }
    
    func lineChartUpdate () {
        recentAvg = 0.0
        let currentLevels = MoodDatabase.db.selectAllFromDatabase()
        
        // 1 - creating an array of data entries
        var yValues : [ChartDataEntry] = [ChartDataEntry]()
        print("yvalues are \(yValues)")
        for i in 0 ..< currentLevels.count {
            recentAvg = recentAvg + Double(currentLevels[i].level)
            yValues.append(ChartDataEntry(x: Double(i + 1), y: Double(currentLevels[i].level)))
        }
        
        recentAvg = recentAvg / Double(currentLevels.count)
             print(recentAvg)
        if currentLevels.count > 3 {
            recentAvg = 0
            for i in (currentLevels.count-3) ..< currentLevels.count {
                recentAvg = recentAvg + Double(currentLevels[i].level)
            }
            recentAvg = recentAvg / 3.0
            print(recentAvg)
        }
        
        lineChart.backgroundColor = UIColor.white
        let data = LineChartData()
        let ds = LineChartDataSet(entries: yValues)
        data.addDataSet(ds)
        lineChart.data = data
        recentAvg = round(100 * recentAvg) / 100
        label.text = "Your recent average mood is \(recentAvg) out of 10."
        //        print("this is line chart \(lineChart)")
        //This must stay at end of function
        lineChart.notifyDataSetChanged()
        
    }
    
    //    func frequencyChartUpdate () {
    //        let words = MoodDatabase.db.selectAllFromDatabase()
    //        let p = MoodDatabase.db
    //          for i in 0 ..< words.count {
    //
    //            socialArray.append(words[i].socialization)
    //            tempArray.append(words[i].temperament)
    //            outArray.append(words[i].nature)
    //            motivationArray.append(words[i].drive)
    //            sleepArray.append(words[i].rest)
    //            relaxArray.append(words[i].calm)
    //        }
    //        print(p)
    //        print("These are the words \(words)")
    //        let entry1 = BarChartDataEntry(x: 1.0, y: 8.0)
    //        let entry2 = BarChartDataEntry(x: 2.0, y: 3.0)
    //        let entry3 = BarChartDataEntry(x: 3.0, y: 5.0)
    //        let dataSet = BarChartDataSet(entries: [entry1, entry2, entry3], label: "Widgets Type")
    //        //filler data for bar chart until I get  tags to work with
    //        let data = BarChartData(dataSets: [dataSet])
    //        frequencyChart.data = data
    ////        print("this is frequency chart \(frequencyChart)")
    //        frequencyChart.chartDescription?.text = "Number of Widgets by Type"
    //
    //        //All other additions to this function will go here
    //
    //        //This must stay at end of function
    //        frequencyChart.notifyDataSetChanged()
    //    }
    
    
    
    
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
        lineChartUpdate()
        //                   frequencyChartUpdate()
        //                          pieChartUpdate()
    }
    
    
}

