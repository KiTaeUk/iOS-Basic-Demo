//
//  ViewController.swift
//  Delegate-TextField
//
//  Created by LEO on 2023/05/10.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tf: UITextField!
    

    
    override func viewDidLoad() {

        // 텍스트 필드. 속성 설정
        self.tf.placeholder = "값을 입력하세요"
        self.tf.keyboardType = UIKeyboardType.alphabet
        self.tf.keyboardAppearance = UIKeyboardAppearance.dark
        self.tf.returnKeyType = UIReturnKeyType.join
        self.tf.enablesReturnKeyAutomatically = true
        
        // 스타일 설정
        self.tf.borderStyle = UITextField.BorderStyle.line
        self.tf.contentVerticalAlignment = .center
        self.tf.contentHorizontalAlignment = .center
        self.tf.layer.borderColor = UIColor.darkGray.cgColor
        self.tf.layer.borderWidth = 2.0
        
        
        // 텍스트 필드를 최초 응답자로 지정
        // self.tf.becomeFirstResponder()
        
        // 델리게이트 지정
        self.tf.delegate = self
        // "텍스트필드에 미리 정해진 이벤트가 발생하면 현재 뷰 컨트롤러에 알려달라는 요청"
    }

    @IBAction func input(_ sender: Any) {
        // 텍스트 필드를 최초 응답자 객체로 지정
        self.tf.becomeFirstResponder()

    }
    
    @IBAction func confirm(_ sender: Any) {
        // 텍스트 필드를 최초 응답자 객체에서 해제
        self.tf.resignFirstResponder()
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 내용이 삭제됩니다")
        return true        // false를 리턴하면 삭제되지 않는다
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("텍스트 필드의 내용이 \(string)으로 변경됩니다")
        // 숫자입력 차단
        if Int(string) == nil {     // 입력된 값이 숫자가 아니라면 true를 리턴
            if (textField.text?.count)! + string.count > 10 {
                return false
            } else {        // 입력된 값이 숫자라면 false 리턴
                return true
            }
        } else{
            return false
        }
        return true
    }
    // 이를 응용하면 특정 문자열을 입력 차단하거나 제어할 수 있다
    // 델리게이트 메서드는 이처럼
    // 특정 객체에서 발생하는 이벤트에 맞추어 우리가 원하는 기능을 실행시키고 싶을 때 유용한 해결책으로 사용된다.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌러졌습니다")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 종료됩니다")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집이 종료되었습니다.")
    }
    
}

