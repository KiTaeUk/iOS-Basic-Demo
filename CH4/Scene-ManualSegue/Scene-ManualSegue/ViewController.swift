//
//  ViewController.swift
//  Scene-ManualSegue
//
//  Created by 기태욱 on 2023/03/03.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func wind(_ sender: Any) {
        // Segue 실행
        self.performSegue(withIdentifier: "ManualWind", sender: self)
    }
}

