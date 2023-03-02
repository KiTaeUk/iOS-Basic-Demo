//
//  ViewController.swift
//  Scene-Trans01
//
//  Created by 기태욱 on 2023/03/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moveNext(_ sender: Any) {
        // 이동할 뷰 컨트롤러 객체를 StoryboardID 정보를 이용하여 참조! (참조될 때 타입은 UIStoryboard)
        // (새로 표시할 뷰 컨트롤러를 스토리보드로부터 읽어와 인스턴스화)
        let uvc = self.storyboard!.instantiateViewController(withIdentifier: "SecondVC")
        
        // 화면 전환할 때의 애니메이션 타입
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        // + .crossDessolve / .flipHorizontal / .partialCurl
        
        // 인자값으로 뷰 컨트롤러 인스턴스를 넣고 프레젠트 메소드 호출
        self.present(uvc, animated: true)
        
        
//        // 옵셔널 바인딩 구문으로 보강한다면..
//        if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") {
//
//            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
//
//            self.present(uvc, animated: true)
//        }
        
        
        
//        // guard 구문으로 보강한다면..
//        guard let uvc = self.storyboard!.instantiateViewController(withIdentifier: "SecondVC") else {
//            return
//        }
//        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
//
//        self.present(uvc, animated: true)
        
        
    }
    
    
}

