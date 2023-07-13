//
//  ViewController.swift
//  Delegate-ImagePicker
//
//  Created by LEO on 2023/05/30.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 컨트롤러 인스턴스 생성
        let picker = UIImagePickerController()  // 라이브러리 선택
        picker.sourceType = .photoLibrary       // 이미지 편집 기능
        picker.allowsEditing = true
        
        // +++ 추가된 부분 : 델리게이트 지정
        picker.delegate = self
        
        
        // 이미지 피커 컨트롤러 실행
        self.present(picker, animated: false)
        // info.plist -> Privacy - Photo Library Usage Description or Camera Usage Description 키 : YES 값
    }
}


// MARK: - 이미지 피커 컨트롤러 델리게이트 메서드
extension ViewController : UIImagePickerControllerDelegate {
    
    // 피커에서 이미지를 선택안하고 취소했을 때 실행되는 메서드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 피커 컨트롤러 창 닫기
        //    = picker.presentingViewController?.dismiss(animated: false)
        //    = self.dismiss(animated: false)
        // 내부적으로 알아서 연결시켜줌 -> 이 메서드가 호출되면
        //  1) 가장 먼저 자신이 치워야 할 뷰 컨트롤러가 있는지 확인
        //  2) 만약 자신의 위에 다른 화면이 덮고 있다면 그것을 치우지만 아무 화면도 없다면 잘못된 요청으로 간주하고 self.presen.. 객체에 전달
        picker.dismiss(animated: false) {
            // 알림창 호출
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    
    
    // 피커에서 이미지를 선택했을 때 실행되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            // 이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imgView.image = img
        }
    }
    
}


// MARK: - 내비게이션 컨트롤러 델리게이트 메서드
extension ViewController : UINavigationControllerDelegate {
    
}


