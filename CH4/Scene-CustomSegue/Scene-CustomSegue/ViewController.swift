//
//  ViewController.swift
//  Scene-CustomSegue
//
//  Created by LEO on 2023/03/03.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "custom_segue"){
            NSLog("커스텀 세그가 실행됩니다")
        } else if(segue.identifier == "action_segue"){
            NSLog("액션 세그가 실행됩니다")

        } 
        
        
        
    }
}

