//
//  HomeViewController.swift
//  LightsOut
//
//  Created by user1 on 2020/05/28.
//  Copyright © 2020 yama9112. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let segueGameView = "segueGameView"
    var line = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapBeginner(_ sender: Any) {
        line = 3
        performSegue(withIdentifier: segueGameView, sender: nil)
    }
    
    @IBAction func tapIntermediate(_ sender: Any) {
        line = 5
        performSegue(withIdentifier: segueGameView, sender: nil)
    }
    
    @IBAction func tapAdvanced(_ sender: Any) {
        line = 7
        performSegue(withIdentifier: segueGameView, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueGameView {
            let next = segue.destination as? GameViewController
            next?.line = line
        }
    }

}

