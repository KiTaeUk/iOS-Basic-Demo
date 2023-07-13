//
//  SecondViewController.swift
//  Scene-Trans02
//
//  Created by LEO on 2023/03/03.
//

import UIKit

class SecondViewController : UIViewController {
        
    // + ctrl 당겼을 때 요소가 추가 되지 않는다...
    @IBAction func back(_ sender : Any){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // @discardableResult 어노테이션을 이용하면 반환값 안 받아도 된다
    @IBAction func backByNavi(_ sender : Any){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
