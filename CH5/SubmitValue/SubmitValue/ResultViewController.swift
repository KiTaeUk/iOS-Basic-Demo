//
//  ResultViewController.swift
//  SubmitValue
//

import Foundation
import UIKit

class ResultViewController : UIViewController {
    @IBOutlet var resultEmail : UILabel!
    @IBOutlet var resultUpdate : UILabel!
    @IBOutlet var resultInterval : UILabel!

    // Outlet 변수는 외부에서 직접 값을 대입할 수 없는 변수
    // (외부 객체에서 직접 참조할 수 없도록 제한)
    // 대신 시스템에 의해 값이 주입된다
    
    var paramEmail : String = ""
    
    var paramUpdate : Bool = false
    
    var paramInterval : Double = 0
    
    
    override func viewDidLoad() {
        self.resultEmail.text = paramEmail
        self.resultUpdate.text = (self.paramUpdate == true ? "자동갱신" : "자동갱신안함")
        self.resultInterval.text = "\(Int(paramInterval))분 마다 갱신"
    }
    
    @IBAction func onBack(_ sender : Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
