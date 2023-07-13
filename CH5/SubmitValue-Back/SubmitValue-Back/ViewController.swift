//
//  ViewController.swift
//  SubmitValue-Back
//
//  Created by LEO on 2023/03/27.
//

import UIKit

class ViewController: UIViewController {

    // 값을 화면에 표시하기 위한 Outlet 변수들
    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdte: UILabel!
    @IBOutlet var resultInterval: UILabel!

    // 값을 직접 전달받을 프로퍼티들
//    var paramEmail : String?
//    var paramUpdate : Bool?
//    var paramInterval : Double?
    
    
    // 화면이 표시될 때마다 실행되는 메서드
    // - 이미 만들어져 있는 인스턴스임으로 viewDidLoad가 아니라 viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
//        if let email = paramEmail {
//            resultEmail.text = email
//        }
//
//        if let update = paramUpdate {
//            resultUpdte.text = update==true ? "자동갱신" : "자동갱신안함"
//        }
//
//        if let interval = paramInterval {
//            resultInterval.text = "\(Int(interval))분마다"
//        }
        
        
        // Case 2
//        // AppDelegate 객체의 인스턴스를 가져온다
//        let ad = UIApplication.shared.delegate as? AppDelegate
//
//        if let email = ad?.paramEmail {
//            resultEmail.text = email
//        }
//        if let update = ad?.paramUpdate {
//            resultUpdte.text = update==true ? "자동갱신" : "자동갱신안함"
//        }
//        if let interval = ad?.paramInterval {
//            resultInterval.text = "\(Int(interval))분마다"
//        }
        
        
        // Case 3
        // UserDefaults 객체의 인스턴스를 가져온다
        let ud = UserDefaults.standard
        
        if let email = ud.string(forKey: "email"){
            resultEmail.text = email
        }
        
        let update = ud.bool(forKey: "isUpdate")
        resultUpdte.text = (update == true ? "자동갱신" : "자동갱신안함")
        
        let interval = ud.double(forKey: "interval")
        resultInterval.text = "\(Int(interval))분마다"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

