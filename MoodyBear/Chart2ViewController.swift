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

    var eat: Int = 0
    var out: Int = 0
    var temp: Int = 0
    var social: Int = 0
    var motivation: Int = 0
    var sleep: Int = 0
    var relax: Int = 0

    
    @IBOutlet var frequencyChart: BarChartView!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        frequencyChartUpdate()

    }
    
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
//                frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
                frequencyChart.xAxis.granularityEnabled = true
                frequencyChart.xAxis.drawGridLinesEnabled = false
                frequencyChart.xAxis.labelPosition = .bottom
                frequencyChart.xAxis.labelCount = labels.count
        //        frequencyChart.xAxis.granularity = 2
                frequencyChart.leftAxis.enabled = true
        let a = LegendEntry.init(label: "Food", form: .square, formSize: 4, formLineWidth: 4, formLineDashPhase: 4, formLineDashLengths: [1,1], formColor: UIColor.red)
        let b = LegendEntry.init(label: "Outside", form: .square, formSize: 4, formLineWidth: 4, formLineDashPhase: 4, formLineDashLengths: [1,1], formColor: UIColor.green)
        let c = LegendEntry.init(label: "Temperament", form: .square, formSize: 4, formLineWidth: 4, formLineDashPhase: 4, formLineDashLengths: [1,1], formColor: UIColor.blue)
        let d = LegendEntry.init(label: "Social", form: .square, formSize: 4, formLineWidth: 4, formLineDashPhase: 4, formLineDashLengths: [1,1], formColor: UIColor.systemPink)
        let e = LegendEntry.init(label: "Motivation", form: .square, formSize: 4, formLineWidth: 4, formLineDashPhase: 4, formLineDashLengths: [1,1], formColor: UIColor.purple)
        let f = LegendEntry.init(label: "Sleep", form: .square, formSize: 4, formLineWidth: 4, formLineDashPhase: 4, formLineDashLengths: [1,1], formColor: UIColor.yellow)
        let g = LegendEntry.init(label: "Relaxation", form: .square, formSize: 4, formLineWidth: 4, formLineDashPhase: 4, formLineDashLengths: [1,1], formColor: UIColor.orange)
        let j = [a,b,c,d,e,f,g]
        frequencyChart.legend.setCustom(entries: j)
        
//                frequencyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
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
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        //                lineChartUpdate()
        frequencyChartUpdate()
        //                          pieChartUpdate()
    }
    
    
}

