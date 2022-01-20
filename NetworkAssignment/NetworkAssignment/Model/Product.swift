//
//  Product.swift
//  NetworkAssignment
//
//  Created by neosoft on 28/12/21.
//

import Foundation
import UIKit

struct ProductLoad: Codable{
    let status: Int
    let data: [ProductData]
}

struct ProductData: Codable{
    let id: Int
    let productCategoryId: Int
    let name: String
    let producer: String
    let description: String
    let cost: Int
    let rating: Int
    let viewCount: Int
    let created: String
    let modified: String
    let productImg: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case productCategoryId = "product_category_id"
        case name = "name"
        case producer = "producer"
        case description = "description"
        case cost = "cost"
        case rating = "rating"
        case viewCount = "view_count"
        case created = "created"
        case modified = "modified"
        case productImg = "product_images"
    }
}

//struct ProductImage{
//    let name: String
//    let image: UIImage
//}
