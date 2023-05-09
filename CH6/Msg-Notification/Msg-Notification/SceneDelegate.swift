//
//  SceneDelegate.swift
//  Msg-Notification
//
//  Created by 기태욱 on 2023/05/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    
    
    // 앱이 활성화 상태를 잃었을 때 실행되는 메서드
    func sceneWillResignActive(_ scene: UIScene)  {
        if #available(iOS 10.0, *) {
            
            // 사용자 동의 여부 체크 : getNotificationSettings()메소드
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                
                // 사용자가 Allow 또는 허용 버튼을 눌렀다면 메소드의 인자값 클로저에 전달되는
                // settings 객체에서 .authorizationsStatus() 속성값은
                // UNAuthorizationStatus.authorized 로 설정된다 -> 로컬알림을 발송할 수 있는 상태
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    let nContent = UNMutableNotificationContent()       // 알림 콘텐츠 객체
                    nContent.badge = 1
                    nContent.title = "로컬 알림 메시지"
                    nContent.subtitle = "준비된 내용이 아주 많아요! 얼른 다시 앱을 열어주세요!"
                    nContent.body = "앗! 왜 나갔어요? 어서 들어오세요"
                    nContent.sound = UNNotificationSound.default
                    
                    nContent.userInfo = ["name" : "홍길동"]
                    // 로컬 알림과 함께 전달하고 싶은 값이 있을 때 사용하는 속성(일종의 커스텀 형식으로 정의되는 값)
                    // 화면에 표시되지 않지만 앱 델리게이트 메소드에서는 참조 할 수 있따
                    // 사용자가 알림 메세지를 클릭했을 때 뭔가 처리를 해주기 위해 주가 데이터가 필요하다면
                    // 이 속성에 커스텀 데이터를 정의하여 전달하면 된다
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                    // 알림 발송 조건 객체
                    
                    let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                    // 알림 요청 객체
                    
                    UNUserNotificationCenter.current().add(request)
                    // 노티피케이션 센터에 추가
                    
                } else {
                    print("사용자가 동의하지 않음!!")
                }
            }
        } else {
            // UILocalNotification 객체를 이용한 로컬 알림 (iOS 9 이하)
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

