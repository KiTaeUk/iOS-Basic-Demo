//
//  SecondViewController.swift
//  Scene-Trans01
//
//  Created by 기태욱 on 2023/03/02.
//

import UIKit

class SecondViewController : UIViewController{
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
