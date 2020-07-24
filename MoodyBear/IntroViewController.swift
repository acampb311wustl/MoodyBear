//
//  IntroViewController.swift
//  MoodyBear
//
//  Created by Joy Chen on 7/23/20.
//  Copyright © 2020 Team Moody Bear. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func button(_ sender: Any) {
             let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as? UITabBarController
        print(homeViewController)
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
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
