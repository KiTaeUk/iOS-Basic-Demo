//
//  ViewController.swift
//  NetworkApi
//
//  Created by LEO on 2023/07/13.
//

import UIKit

class ListViewController: UITableViewController {
    
    var list : [MovieVO] = []
    
    // 현재까지 읽어온 API데이터의 페이지 정보를 저장하는 데 사용
    var page = 1
    
    
    override func viewDidLoad() {
        self.callMovieAPI()
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        
        let url : URL! = URL(string: row.thumbnail!)
        
        let imageData = try! Data(contentsOf: url)
        
        cell.thumbnail.image = UIImage(data: imageData)
        
        return cell
    }
    
    
    
    @IBAction func more(_ sender : Any) {
        self.page += 1
        self.callMovieAPI()
        self.tableView.reloadData()
    }
    
    @IBOutlet var moreBtn : UIButton!
    
    
    
    func callMovieAPI() {
        // 1) API호출을 위한 URI 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=10&genreId=&order=releasedateasc"

        let apiURI : URL = URL(string: url)!
        
        
        // 2) REST API를 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        
        // 3) 데이터 전송 결과를 로그로 출력
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        // NSLog("API = Result = \( log )")
        
        
        // ---------------------
        //        let session = URLSession.shared
        //
        //        let task = session.dataTask(with: apiURI) { (data, response, error) in
        //            if error != nil {
        //                print(error!)
        //                return
        //            }
        //
        //            guard let safeData = data else {
        //                return
        //            }
        //
        //
        //            let log = NSString(data: safeData, encoding: String.Encoding.utf8.rawValue) ?? ""
        //            NSLog("API = Result = \( log )")
        //        }
        //
        //        task.resume()
        // ---------------------
        
        // 4) JSON 객체를 파싱하여 NSDictionary 객체로 받음
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary

            // 5) 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray

            // 6) Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다
            for row in movie {
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary

                // 테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()

                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)

                self.list.append(mvo)
            }


            // 7) 전체 데이터 카운트를 얻는다
            let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue

            // 8) totalCount가 읽어온 데이터 크기와 같거나 클 경우 더보기 버튼을 막는다
            if self.list.count >= totalCount {
                self.moreBtn.isHidden = true
            }
        } catch { }
        
        

        
    }
    
    

}

