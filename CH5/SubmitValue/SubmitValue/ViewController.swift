//
//  ViewController.swift
//  SubmitValue
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var isUpdate: UISwitch!
    @IBOutlet weak var interval: UIStepper!
    
    @IBOutlet weak var isUpdateText: UILabel!
    @IBOutlet weak var intervalText: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Any 타입으로 선언하면
    // 장점 : 하나의 액션 메소드를 서로 다른 타입의 컨트롤들이 공용으로 사용할 수 있어 편리
    // 단점 : 해당 인자값을 사용해야 할 때에는 다시 하위 타입으로 캐스팅해주어야 하는 번거로움
    @IBAction func onSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            self.isUpdateText.text = "갱신함"
        } else {
            self.isUpdateText.text = "갱신하지 않음"
        }
    }
    // sender는 스위치컨트롤을 가리키는 값으로, 속성값으로 사용된 isOn은 스위치가 켜저있는지 알려줌
    
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.intervalText.text = "\(value)분 마다"
        
    }

    @IBAction func onSubmit(_ sender: Any) {
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? ResultViewController else {
            return
        }
        
        
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
        
        //        self.present(rvc, animated: true)
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    // 여기서 캐스팅은 어떤 의미일까?
    // instantiateViewController 메소드를 호출하여 생성된 인스턴스는
    // 기본적으로 UIViewController 타입 (뷰컨트롤러 중 가장 상위 클래스)
    
    // 화면 전환만을 목적으로 한다면 이 클래스 타입을 그대로 사용해도 된다
    
    // 단순히 화면 전환하는 것 분만 아니라 전환 대상의 프로퍼티를 참조하고 여기에 값을 대입하기 까지 한다면
    
    // 우리가 참조할 paramEmail, paramUpdate, paramInterval 프로퍼티 들은
    // ResultViewController 클래스에 모두 정의 되 있음으로
    // UIViewController → ResultViewController 로 다운 캐스팅 해야한다.
    
    
    // 세그웨이 전처리 메소드
    override func prepare(for segue: UIStoryboardSegue, sender : Any?) {
        //목적지 뷰 컨트롤러 인스턴스 읽어오기
        let dest = segue.destination
        
        guard let rvc = dest as? ResultViewController else {
            return
        }
        
        // 값 전달
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
    }
    
    @IBAction func onPerformSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualSubmit", sender: self)
    }
    
    
}

