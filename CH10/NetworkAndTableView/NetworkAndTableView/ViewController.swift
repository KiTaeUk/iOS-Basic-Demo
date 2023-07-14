//
//  ViewController.swift
//  NetworkAndTableView
//
//  Created by LEO on 2023/07/14.
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
    
    // 셀 자체는 재사용하지만
    // 셀의 콘텐츠는 이 메소드를 통하여 매번 새롭게 구성된다
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        
        // 재사용 큐에 있는 셀들은 재 사용 식별자를 통해 서로 구별할 수 있는데
        // 속성값으로 입력된 "ListCell"속성이 바로 재사용 식별자(Reuse Identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        
//        let url : URL! = URL(string: row.thumbnail!)
//        let imageData = try! Data(contentsOf: url)
//        cell.thumbnail.image = UIImage(data: imageData)
//        cell.thumbnail.image = row.thumbnailImage
        
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
        // 인자값으로 받은 인덱스를 기반으로 해당하는 배열 데이터를 읽어옴
        let mvo = self.list[index]
        
        // 메모이제이션 : 저장된 이미지가 있으면 그것을 반환하고, 없을 경우 내려받아 저장한 후 반환
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        } else {
            let url : URL! = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data: imageData)   // UIImage를 MovieVo에 우선 저장
            
            return mvo.thumbnailImage!  // 저장된 이미지를 반환
        }
    }
}

