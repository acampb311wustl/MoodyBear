//
//  SecondViewController.swift
//  MoodyBear
//
//  Created by Team Moody Bear on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit
import Charts

class Chart2ViewController: UIViewController  {
    //    @IBOutlet weak var number1: UISlider!
    //    @IBOutlet weak var number2: UISlider!
    //    @IBOutlet weak var number3: UISlider!
    //    var eatArray: [Int] = []
    //       var outArray: [Int] = []
    //       var tempArray: [Int] = []
    //       var socialArray: [Int] = []
    //       var motivationArray: [Int] = []
    //       var sleepArray: [Int] = []
    //       var relaxArray: [Int] = []
    var eat: Int = 0
    var out: Int = 0
    var temp: Int = 0
    var social: Int = 0
    var motivation: Int = 0
    var sleep: Int = 0
    var relax: Int = 0
    //    var lineChart: LineChartView!
    //    @IBOutlet var lineChart: LineChartView!
    //    var barChart: LineChartView!
    
    //    @IBOutlet var pieChart: LineChartView!
    //    @IBOutlet var frequencyChart: LineChartView!
    
    
    //    @IBOutlet var lineChart: LineChartView!
    
    //    @IBOutlet var frequencyChart: BarChartView!
    
    @IBOutlet var frequencyChart: BarChartView!
    //    @IBOutlet var lineChart: LineChartView!
    
    
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
        
        for i in 0 ..< words.count {
            eat = words[i].food + eat
            out = words[i].nature + out
            temp = words[i].temperament + temp
            social = words[i].socialization + social
            motivation = words[i].drive + motivation
            sleep = words[i].rest + sleep
            relax = words[i].calm + relax
            
        }
        print(eat)
        print(out)
        print(sleep)
        
        print("These are the words \(words)")
        
                let entry1 = BarChartDataEntry(x: 1.0, y: Double(eat))
                let entry2 = BarChartDataEntry(x: 2.0, y: Double(out))
                let entry3 = BarChartDataEntry(x: 3.0, y: Double(temp))
                let entry4 = BarChartDataEntry(x: 4.0, y: Double(social))
                let entry5 = BarChartDataEntry(x: 5.0, y: Double(motivation))
                let entry6 = BarChartDataEntry(x: 6.0, y: Double(sleep))
                let entry7 = BarChartDataEntry(x: 7.0, y: Double(relax))
                let labels = ["Food", "Outside", "Temperament", "Social", "Motivation", "Sleep", "Relaxation"]
        
                frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
                let dataSet = BarChartDataSet(entries: [entry1, entry2, entry3, entry4, entry5, entry6, entry7], label: "Mood Factors")
                //filler data for bar chart until I get  tags to work with
                dataSet.colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.systemPink, UIColor.purple, UIColor.yellow, UIColor.orange]
                let data = BarChartData(dataSets: [dataSet])
                frequencyChart.data = data
        //        print("this is frequency chart \(frequencyChart)")
                frequencyChart.chartDescription?.text = "Mood Factors"
        
                //All other additions to this function will go here
        
                //This must stay at end of function
                frequencyChart.notifyDataSetChanged()
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
    
    
}

