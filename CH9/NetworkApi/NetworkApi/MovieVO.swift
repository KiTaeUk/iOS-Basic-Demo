//
//  MovieVO.swift
//  NetworkApi
//
//  Created by LEO on 2023/07/13.
//

import Foundation

class MovieVO : Codable {
    var thumbnail : String?     // 영화 섬네일 이미지 주소
    var title : String?         // 영화 제목
    var description : String?  // 영화 설명
    var detail : String?        // 상세설명
    var opendate : String?      // 개봉일
    var rating : Double?        // 평점
}
