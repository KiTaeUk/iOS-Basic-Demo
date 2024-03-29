//
//  TheaterViewController.swift
//  MapKit
//
//  Created by LEO on 2023/08/18.
//

import UIKit
import MapKit

class TheaterViewController : UIViewController {
    
    @IBOutlet var map : MKMapView!
    
     // 전달되는 데이터를 받을 변수
    var param : NSDictionary!
    
    override func viewDidLoad() {
        self.navigationItem.title = self.param["상영관명"] as? String
        
        // 1. 위도와 경도를 추출하여 Double 값으로 캐스팅
        let lat = (param?["위도"] as! NSString).doubleValue
        let lng = (param?["경도"] as! NSString).doubleValue
        
        // 2. 위도와 경도를 인수로 하는 2D 위치 정보 객체 정의
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        // 3. 지도에 표현될 거리 : 값의 단위는 m
        let regionRadius : CLLocationDistance = 100
        
        // 4. 거리를 반영한 지역 정보를 조합한 지도 데이터를 생성
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius )
        
        // 5. map 변수에 연결된 지도 객체에 데이터를 전달하여 화면에 표시
        self.map.setRegion(coordinateRegion, animated: true)
        
    }
    
    

}
