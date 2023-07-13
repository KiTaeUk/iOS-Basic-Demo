//
//  ViewController.swift
//  Msg-Notification
//
//  Created by LEO on 2023/05/09.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var msg: UITextField!
    @IBOutlet weak var datepicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func save(_ sender: Any) {
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    
                    // 알림 설정이 들어갈 곳
                    DispatchQueue.main.async {
                        
                        // 1단계
                        let nContent = UNMutableNotificationContent()
                        nContent.body = (self.msg.text)!
                        nContent.title = "미리 알림"
                        nContent.sound = UNNotificationSound.default
                        
                        // 발송 시각을 '지금으로 부터 _초 형식으로 변환
                        let time = self.datepicker.date.timeIntervalSinceNow
                        
                        // 2단계
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                        
                        // 3단계
                        let request = UNNotificationRequest(identifier: "alarm", content: nContent, trigger: trigger)
                                                            
                        // 4단계
                        UNUserNotificationCenter.current().add(request) { (_) in
                            DispatchQueue.main.async {
                                let date = self.datepicker.date.addingTimeInterval(9*60*60)
                                let message = "알림이 등록되엇습니다. 등록된 알림은 \(date)에 발송됩니다"
                                
                                let alert = UIAlertController(title: "알림등록", message: message, preferredStyle: .alert)
                                
                                let ok = UIAlertAction(title: "확인", style: .default)
                                
                                alert.addAction(ok)
                                
                                self.present(alert, animated: false)
                            }
                        }
                        
                    }
                } else {
                    let alert = UIAlertController(title: "알림 등록", message: "알림이 허용되어 있지 않습니다", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default)
                    
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false)
                    
                    return
                }
            }
        }
    }
    
    
    
    
}

