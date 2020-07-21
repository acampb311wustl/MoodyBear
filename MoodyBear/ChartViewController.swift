//
//  SecondViewController.swift
//  MoodyBear
//
//  Created by Team Moody Bear on 7/18/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    @IBOutlet weak var number1: UISlider!
    @IBOutlet weak var number2: UISlider!
    @IBOutlet weak var number3: UISlider!
    @IBOutlet weak var barChart: LineChartView!
    
//    @IBOutlet var pieChart: LineChartView!
//    @IBOutlet var frequencyChart: LineChartView!
    
    @IBOutlet weak var frequencyChart: BarChartView!
    @IBOutlet weak var pieChart: PieChartView!
    @IBAction func renderCharts() {
        barChartUpdate()
        frequencyChartUpdate()
          pieChartUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        barChartUpdate()
        frequencyChartUpdate()
        pieChartUpdate()
    }
    
    func barChartUpdate () {
        let currentLevels = MoodDatabase.db.selectAllFromDatabase()

        // 1 - creating an array of data entries
        var yValues : [ChartDataEntry] = [ChartDataEntry]()

        for i in 0 ..< currentLevels.count {
            yValues.append(ChartDataEntry(x: Double(i + 1), y: Double(currentLevels[i].level)))
        }

        let data = LineChartData()
        let ds = LineChartDataSet(entries: yValues)
        data.addDataSet(ds)
        barChart.data = data
         print("this is line chart \(barChart)")
        //This must stay at end of function
        barChart.notifyDataSetChanged()
    }
    
    func frequencyChartUpdate () {
        let words = MoodDatabase.db.selectAllFromDatabase()
        print("These are the words \(words)")
        let entry1 = BarChartDataEntry(x: 1.0, y: 8.0)
        let entry2 = BarChartDataEntry(x: 2.0, y: 3.0)
        let entry3 = BarChartDataEntry(x: 3.0, y: 5.0)
        let dataSet = BarChartDataSet(entries: [entry1, entry2, entry3], label: "Widgets Type")
        //filler data for bar chart until I get  tags to work with
        let data = BarChartData(dataSets: [dataSet])
        frequencyChart.data = data
        print("this is frequency chart \(frequencyChart)")
        frequencyChart.chartDescription?.text = "Number of Widgets by Type"

        //All other additions to this function will go here

        //This must stay at end of function
        frequencyChart.notifyDataSetChanged()
    }
    
    
    
    
    func pieChartUpdate () {
        let entry1 = PieChartDataEntry(value: 4, label: "#1")
        let entry2 = PieChartDataEntry(value: 2, label: "#2")
        let entry3 = PieChartDataEntry(value: 9, label: "#3")
        let dataSet = PieChartDataSet(entries: [entry1, entry2, entry3], label: "Widget Types")
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChart.chartDescription?.text = "Share of Widgets by Type"

        //All other additions to this function will go here
print("this is pie chart \(pieChart)")
        //This must stay at end of function
        pieChart.notifyDataSetChanged()
    }
    override func viewWillAppear(_ animated: Bool) {
        barChartUpdate()
           frequencyChartUpdate()
                  pieChartUpdate()
    }

    
}

