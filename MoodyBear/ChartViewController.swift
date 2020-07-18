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
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var barChart: LineChartView!
    
    
    @IBAction func renderCharts() {
        barChartUpdate()
        pieChartUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        barChartUpdate()
        pieChartUpdate()
    }
    
    func barChartUpdate () {
     
        let dollars1 = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        // 1 - creating an array of data entries
        var yValues : [ChartDataEntry] = [ChartDataEntry]()

        for i in 0 ..< months.count {
            yValues.append(ChartDataEntry(x: Double(i + 1), y: dollars1[i]))
        }

        let data = LineChartData()
        let ds = LineChartDataSet(entries: yValues, label: "Months")
        data.addDataSet(ds)
        barChart.data = data
    
        //This must stay at end of function
        barChart.notifyDataSetChanged()
        
    }
    func pieChartUpdate () {
        let entry1 = PieChartDataEntry(value: Double(number1.value), label: "#1")
        let entry2 = PieChartDataEntry(value: Double(number2.value), label: "#2")
        let entry3 = PieChartDataEntry(value: Double(number3.value), label: "#3")
        let dataSet = PieChartDataSet(entries: [entry1, entry2, entry3], label: "Widget Types")
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChart.chartDescription?.text = "Share of Widgets by Type"
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        pieChart.notifyDataSetChanged()
        
    }
    
}

