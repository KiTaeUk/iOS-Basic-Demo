//
//  ViewController.swift
//  Scene-Trans02
//
//  Created by LEO on 2023/03/03.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moveByNavi(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        
        // 화면 전환
        self.navigationController?.pushViewController(uvc, animated: true)
        // 만약 뷰 컨트롤러에 내비게이션 컨트롤러가 연결되어 있지 않을 경우 Nil값을 return
    }
    
    @IBAction func movePresent(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        
        self.present(uvc, animated: true)
    }
}

