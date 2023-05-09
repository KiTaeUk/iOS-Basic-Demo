//
//  AppDelegate.swift
//  Msg-Notification
//
//  Created by 기태욱 on 2023/05/09.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {


    // 앱이 처음 실행될 때 호출되는 메소드
    //     (앱에서 사용할 클래스/리소스들이 모두 메모리에 로드되고 아직 앱이 첫 화면을 모바일 디바이스에 띄우기 직전)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if #available(iOS 10.0, *){
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고 사용자 동의 여부 창을 실행
            
            // 싱글톤 패턴이다 -> 시스템에서 만들어 놓은 인스턴스를 받아서 사용해야함 : 밑은 시스템에서 제공하는 인스턴스를 받아오는 방법
            let notiCenter = UNUserNotificationCenter.current()
            
            // 알림 설정에 대한 동의
            // 동의했을 때 처리할 작업은 두번째 인자값(클로저)에서 처리 (didAllow, e)
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (didAllow, e) in }
            
            // "알림 센터와 관련하여 사건이 발생하면 self(앱 델리게이트)한테 알려줘"
            notiCenter.delegate = self
        } else {
            print("no..")

        }
        
        return true
    }
    
    
    // + 앱 실행 도중에 알림 메세지가 도착한 경우
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier == "wakeup" {
            let userInfo = notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        
        // 알림 배너 띄어주기
        completionHandler([.alert, .badge, .sound])
    }
    
    // + 사용자가 알림 메세지를 클릭했을 경우 (차이점 : 클릭시 이 메서드 실행됨)
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "wakeup" {
            let userInfo = response.notification.request.content.userInfo
            print(userInfo["name"]!)
        }
    }
    
    
    
//    iOS 13 이후 변경된 생명주기 이벤트 전달 방식 때문에
//    백그라운드에 들어갔을 때 호출되는 메소드는
//    AppDelegate.swift의 applicationWillResignActive(_:)가 아닌
//    SceneDelegate.swift의 sceneWillResignActive(_:)임.
    
//      앱이 활성화 상태를 잃었을 때 실행되는 메서드
//    func applicationWillResignActive(_ application: UIApplication) {
//        if #available(iOS 10.0, *){
//
//            // 알림 동의 여부를 확인
//            UNUserNotificationCenter.current().getNotificationSettings { settings in
//
//                if settings.authorizationStatus == UNAuthorizationStatus.authorized{
//
//                    // 1단계 : 알림 콘텐츠 객체
//                    let nContent = UNMutableNotificationContent()
//                    nContent.badge = 1
//                    nContent.title = "로컬 알림 메세지"
//                    nContent.subtitle = "준비된 내용이 많아요, 다시 앱을 열어주세요"
//                    nContent.body = "왜 나가셨나요, 다시 들어오시죠"
//                    nContent.sound = UNNotificationSound.default
//                    nContent.userInfo = ["name" : "홍길동"]
//
//                    // 2단계 : 알림 발송 조건 객체
//                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
//
//                    // 3단계 : 알림 요청 객체
//                    let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
//
//                    // 4단계 : 노티피케이션 센터에 추가
//                    UNUserNotificationCenter.current().add(request)
//
//                } else {
//                    print("사용자가 동의하지 않음")
//                }
//            }
//        } else {
//            // iOS 9이하
//            print("no..")
//        }
//    }
    

    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
        
    }


}

