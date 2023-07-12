//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by LEO on 2023/07/11.
//

import UIKit

class ListViewController : UITableViewController {
    
    // 리펙토링
    var dataset = [("다크 나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다", "2008-09-04", 8.95, "darknight.jpg"),
                   ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "rain.jpg"),
                   ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "2015-05-07", 9.19, "secret.jpg")
    ]
  
    
    lazy var list : [MovieVO] = {
        var datalist = [MovieVO]()
        for (title, desc, opendate, rating, thumbnail) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            mvo.thumbnail = thumbnail
            
            datalist.append(mvo)
        }
        
        return datalist
    }()
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다
        let row = self.list[indexPath.row]
        
        // 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴 + 변경
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell

        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        cell.thumbnail?.image = UIImage(named: row.thumbnail!)
        
// ------
//        커스텀 추가 방법1
//        let title = cell.viewWithTag(101) as? UILabel
//        let desc = cell.viewWithTag(102) as? UILabel
//        let opendate = cell.viewWithTag(103) as? UILabel
//        let rating = cell.viewWithTag(104) as? UILabel
//
//        // 데이터 소스에 저장된 값을 각 레이블 변수에 할당
//        title?.text = row.title
//        desc?.text = row.description
//        opendate?.text = row.opendate
//        rating?.text = "\(row.rating!)"
// ------
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다")
    }
    // 코드 스니펫? : 자동완성 기능?
    
    
    
    
//    var list = [MovieVO]()
    
//    override func viewDidLoad() {
//        // 첫번째 행
//        var mvo = MovieVO()
//        mvo.titile = "다크나이트"
//        mvo.description = "영웅물에 철학에 음악까지 더해져 예술이 되다."
//        mvo.opendate = "2008-09-04"
//        mvo.rating = 8.95
//        // 배열에 추가
//        self.list.append(mvo)
//
//        // 두번째 행
//        mvo = MovieVO()
//        mvo.titile = "호우시절"
//        mvo.description = "때를 알고 내리는 좋은 비"
//        mvo.opendate = "2009-10-08"
//        mvo.rating = 7.31
//        // 배열에 추가
//        self.list.append(mvo)
//
//        // 세번째 행
//        mvo = MovieVO()
//        mvo.titile = "말할 수 없는 비밀"
//        mvo.description = "여기서 너까지 다섯 걸음"
//        mvo.opendate = "2015-05-07"
//        mvo.rating = 9.19
//        // 배열에 추가
//        self.list.append(mvo)
        
        // mvo = MoviewVO()
        // 레퍼런스 타입이므로 배열에 값을 넣은 후에도 연결되어 있다
        // MovieVO 인스턴스의 연결을 끊고 새 연결을 만들어 줄 필요로 인한 코드
//    }
    
}
