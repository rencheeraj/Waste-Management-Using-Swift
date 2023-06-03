//
//  ResponseModel.swift
//  WasteManagement
//
//  Created by Rencheeraj Mohan on 02/06/23.
//

import Foundation
// MARK: - Response
struct Response : Codable{
    let status : String
    let data : DataModelClass
}
// MARK: - DataModelClass
struct DataModelClass: Codable {
    let featuredProducts : [FeaturedProduct]
    let featuredAdvertisement, bwgAdvertisement : [Advertisement]
    let featuredPackages : [FeaturedPackage]
    enum CodingKeys: String, CodingKey{
        case featuredProducts = "featured_products"
        case featuredAdvertisement = "featured_advertisement"
        case bwgAdvertisement = "bwg_advertisement"
        case featuredPackages = "featured_packages"
    }
}
// MARK: - FeaturedProduct
struct FeaturedProduct : Codable{
    let id,name,type,image : String
    let products : [ProductData]
}
// MARK: - ProductData
struct ProductData : Codable {
    let product_id,product_name : String
    let images : String
    let price: String
    let unit : String
    let type : String
}
// MARK: - Advertisement
struct Advertisement : Codable{
    let id, name, image, videoURL, externalLink : String
    
    enum CodingKeys : String, CodingKey{
        case id, name, image
        case videoURL = "video_url"
        case externalLink = "external_link"
    }
}
// MARK: - FeaturedPackage
struct FeaturedPackage : Codable{
    let id, name, type, amount : String
    let duration : String
}
// MARK: - UnitScale
enum UnitScale : String, Codable{
    case kg = "Kg"
    case ltr = "Ltr"
    case pcs = "Pcs"
}
