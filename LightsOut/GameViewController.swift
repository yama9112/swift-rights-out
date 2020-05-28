//
//  GameViewController.swift
//  LightsOut
//
//  Created by user1 on 2020/05/28.
//  Copyright © 2020 yama9112. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var countLabel: UILabel!
    var list: Array<Data> = []
    var line = 3
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        verticalStackView.distribution = .fillEqually
        initView()
    }
    
    func initView() {
        for subView in verticalStackView.subviews {
            verticalStackView.removeArrangedSubview(subView)
            subView.removeFromSuperview()
        }
        list.removeAll()
        count = 0
        countLabel.text = "手数：\(count)"
        
        for _ in 1...line {

            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            verticalStackView.addArrangedSubview(stackView)
            
            for _ in 1...line {

                let view = UIView()
                view.backgroundColor = .yellow
                view.layer.borderWidth = 1
                view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTaped)))
                
                let data = Data(light: true, view: view)
                list.append(data)
                view.tag = list.count - 1
                stackView.addArrangedSubview(view)
                
            }
            
        }
    }
    
    
    @IBAction func reset(_ sender: Any) {
        initView()
    }
    
    
    @objc func viewTaped(sender: UITapGestureRecognizer) {
        if let tapView = sender.view {
            let num = tapView.tag
            changeLight(num: num)
            
            // top
            let topNum = num - line
            if list.indices.contains(topNum) {
                changeLight(num: topNum)
            }
            
            // bottom
            let bottonNum = num + line
            if list.indices.contains(bottonNum) {
                changeLight(num: bottonNum)
            }
            
            let col = num % line
            
            // left
            if col > 0 {
                changeLight(num: num - 1)
            }
            
            // right
            if col < (line - 1) {
                changeLight(num: num + 1)
            }
        }
        
        count += 1
        countLabel.text = "手数：\(count)"
        
        if checkResult() {
            print("win!!")
        }
    }
    
    func changeLight(num: Int) {
        let data = list[num]
        data.light = !data.light
        data.view.backgroundColor = data.light ? UIColor.yellow : UIColor.gray
    }
    
    func checkResult() -> Bool {
        for data in list {
            if data.light {
                return false
            }
        }
        return true
    }

}

class Data: NSObject {
    var light: Bool
    var view: UIView
    
    init(light: Bool, view: UIView) {
        self.light = light
        self.view = view
    }
}
