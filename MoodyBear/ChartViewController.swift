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
    
    
    @IBAction func renderCharts() {
        barChartUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        barChartUpdate()
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
    
        //This must stay at end of function
        barChart.notifyDataSetChanged()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        barChartUpdate()
    }

    
}

