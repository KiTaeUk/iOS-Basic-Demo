//
//  MovieVO.swift
//  MyMovieChart
//
//  Created by LEO on 2023/07/12.
//

import Foundation

// 영화 정보를 담기 위한 객체

// Value Object 패턴
// 데이터 저장을 전담하는 클래스를 별도로 분리하는 설계 방식을 Value Object 패턴
class MovieVO {
    var thumbnail : String?
    var title : String?
    var description : String?
    var detail : String?
    var opendate : String?
    var rating : Double?
}
