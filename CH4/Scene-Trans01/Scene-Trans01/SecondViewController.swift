//
//  SecondViewController.swift
//  Scene-Trans01
//
//  Created by LEO on 2023/03/02.
//

import UIKit

class SecondViewController : UIViewController{
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
