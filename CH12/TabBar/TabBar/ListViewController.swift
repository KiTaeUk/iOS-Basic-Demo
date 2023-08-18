//
//  ViewController.swift
//  TabBar
//
//  Created by LEO on 2023/07/23.
//

import UIKit

class ListViewController: UITableViewController {

    @IBOutlet var moreBtn : UIButton!
        
        var page = 1
        
        lazy var list : [MovieVO] = {
            var datalist = [MovieVO]()
            return datalist
        }()
        
        @IBAction func more(_ sender : Any) {
            self.page += 1
            
            self.callMovieAPI()
            
            self.tableView.reloadData()
        }
        
        
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
            

            
            DispatchQueue.main.async(execute: {
                cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
            })
            
            return cell
        }
        
        
        func callMovieAPI() {

            let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=10&genreId=&order=releasedateasc"

            let apiURI : URL = URL(string: url)!
            
            let apidata = try! Data(contentsOf: apiURI)
            

            
            do {
                let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary

                let hoppin = apiDictionary["hoppin"] as! NSDictionary
                let movies = hoppin["movies"] as! NSDictionary
                let movie = movies["movie"] as! NSArray

                for row in movie {
                    let r = row as! NSDictionary

                    let mvo = MovieVO()
                    
                    mvo.title = r["title"] as? String
                    mvo.description = r["genreNames"] as? String
                    mvo.thumbnail = r["thumbnailImage"] as? String
                    mvo.detail = r["linkUrl"] as? String
                    mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                    
                    
                    let url : URL! = URL(string: mvo.thumbnail!)
                    let imageData = try! Data(contentsOf: url)
                    mvo.thumbnailImage = UIImage(data: imageData)

                    self.list.append(mvo)
                }

                let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue

                if self.list.count >= totalCount {
                    self.moreBtn.isHidden = true
                }
            } catch { }
        }


        func getThumbnailImage(_ index : Int) -> UIImage {
            
            let mvo = self.list[index]
            
            if let savedImage = mvo.thumbnailImage {
                return savedImage
            } else {
                let url : URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data: imageData)
                
                return mvo.thumbnailImage!
            }
        }
}


// MARK: - 화면 전환 시 값을 넘겨주기 위한 세그웨이 관련 처리
extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 실행된 세그웨이의 식별자가 "segue_detail"이라면
        if segue.identifier == "segue_detail" {
            
            // 사용자가 클릭한 행을 찾아낸다
            let path = self.tableView.indexPath(for: sender as! MovieCell)
            
            // 행 정보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입한다
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = self.list[path!.row]
        }
    }
}

