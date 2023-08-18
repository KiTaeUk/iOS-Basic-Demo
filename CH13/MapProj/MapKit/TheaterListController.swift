//
//  TheaterListController.swift
//  MapKit
//
//  Created by LEO on 2023/08/18.
//


import UIKit

class TheaterListController : UITableViewController {
    
    // API를 통해 불러온 데이터를 저장할 변수
    var list = [NSDictionary]()
    
    // 읽어올 데이터의 시작위치
    var startPoint = 0
    
    override func viewDidLoad() {
        // API를 호출한다
        self.callTheaterAPI()
    }
    
    // API로부터 극장 정보를 읽어오는 메소드
    func callTheaterAPI() {
        // 1. URL을 구성하기 위한 상수값을 선언
        let requestURI = "http://swiftapi.rubypaper.co.kr:2029/theater/list"
        let sList = 100 // 불러올 데이터 갯수
        let type = "json"
        
        // 2. 인자값들을 모아 URL 객체로 정의한다
        let urlObj = URL(string: "\(requestURI)?s_page=\(self.startPoint)&s_list=\(sList)&type=\(type)")
        
        
        do{
            // 3. NSString 객체를 이용하여 API를 호출하고 그 결과값을 인코딩된 문자열로 받아온다
            let stringdata = try NSString(contentsOf: urlObj!, encoding: 0x80_000_422)
            
            // 4. 문자열로 받은 데이터를 UTF-8로 인코딩 처리한 Data로 변환한다
            let encdata = stringdata.data(using: String.Encoding.utf8.rawValue)
        
            do {
                // 5. Data 객체를 파싱하여 NSArray 객체로 변환한다.
                let apiArray = try JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
                
                // 6. 읽어온 데이터를 순회하면서 self.list 배열에 추가한다
                for obj in apiArray! {
                    self.list.append(obj as! NSDictionary)
                }
                
            } catch {
                // 경고창 형식으로 오류 메시지를 표시해준다.
                let alert = UIAlertController(title: "실패", message: "데이터 분석에 실패하였습니다1", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                self.present(alert, animated: false)
            }
            // 7. 읽어와야 할 다음 페이지의 데이터 시작 위치를 구해 저장해둔다.
            self.startPoint += sList
        } catch {
            // 경고창 형식으로 오류 메시지를 표시해준다
            let alert = UIAlertController(title: "실패", message: "데이터 분석에 실패하였습니다2", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = self.list[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell") as! TheaterCell
        
        cell.name?.text = obj["상영관명"] as? String
        cell.tel?.text = obj["연락처"] as? String
        cell.addr?.text = obj["소재지도로명주소"] as? String

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 실행된 세그웨이의 식별자가 "segue_map"이라면
        if segue.identifier == "segue_map" {
            
            //
            let path = self.tableView.indexPath(for: sender as! UITableViewCell)
            
            // 행 정보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입한다
            let data = self.list[path!.row]
            
            (segue.destination as? TheaterViewController)?.param = data
        }
    }
}
