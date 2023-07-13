//
//  ListViewController.swift
//  Table-CellHeight
//
//  Created by LEO  on 2023/07/12.
//

import UIKit

class ListViewController : UITableViewController {
    
    var list = [String]()
  
    
    @IBAction func add(_ sender : Any){
        
        // 1) 알림창 객체의 인스턴스를 생성한다
        let alert = UIAlertController(title: "목록 입력", message: "추가될 글을 작성해주세요", preferredStyle: .alert)
        
        // 2) 알림창에 입력폼을 추가한다.
        alert.addTextField() { (tf) in
            tf.placeholder = "내용을 입력하세요"
        }
        
        // 3) OK버튼 객체를 생성한다 : 아직 알림창 객체에 버튼이 등록되지 않은 상태
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            
            // 4) 알림창의 0번째 입력필드에 값이 있다면
            if let title = alert.textFields?[0].text{
                // 5) 배열에 입력된 값을 추가하고 테이블을 갱신
                self.list.append(title)
                self.tableView.reloadData()
            }
        }
        
        // 취소 버튼 객체를 생성한다 : 아직 알림창 객체에 버튼이 등록되지 않은 상태
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler : nil)
        
        // 6) 알림창 객체에 버튼 객체를 등록한다
        alert.addAction(ok)
        alert.addAction(cancel)
    
        self.present(alert, animated: false)
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1) "cell"이란 아이디를 가진 셀을 읽어온다. 없으면 UITableViewCell 인스턴스를 생성한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        // 셀의 기본 텍스트 레이블에 배열 변수의 값을 할당한다.
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.numberOfLines = 0  // 행 수를 강제로 지정하는 속성(기본=1). 0으로 설정 -> 제한을 없엔다
        
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        let row = self.list[indexPath.row]
//
//        // 높이를 조절해준다
//        // 기본 60 + 가변 높이 (글의 길이가 30자를 넘어갈 때마다 20만큼 높여라)
//        let height = CGFloat(60 + (row.count / 30) * 20)
//        return height
//
//    }
    
    
    
}
