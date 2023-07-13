//
//  NewSegue.swift
//  Scene-CustomSegue
//
//  Created by LEO on 2023/03/03.
//

import UIKit

class NewSegue : UIStoryboardSegue {
    
    // UIStoryboardSegue 클래스에서 세그웨이의 실행을 처리하는 메서드가 perform()
    // 커스텀 세그웨이에서도 원하는 화면 전환 기능을 구현하기 위해서는 perform() 메서드를 override 해야함
    
    override func perform(){
        // 세그웨이 출발 VC
        let srcUVC = self.source
        
        // 세그웨이 도착 VC
        let destUVC = self.destination
        
        // formView에서 toView로 뷰를 전환한다
        UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 2, options: .transitionCurlDown)
    }
}
