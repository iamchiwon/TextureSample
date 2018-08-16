//
//  Manga.swift
//  TopMangas
//
//  Created by iamchiwon on 2018. 8. 16..
//  Copyright © 2018년 iamchiwon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Manga: Codable {
    let id: Int
    let rank: Int
    let url: String
    let imageUrl: String
    let title: String
    let score: Float
    let publishingStart: String
    let publishingEnd: String
    let volumes: Int

    init(json: JSON) {
        id = json["mal_id"].intValue
        rank = json["rank"].intValue
        url = json["url"].stringValue
        imageUrl = json["image_url"].stringValue
        title = json["title"].stringValue
        score = json["score"].floatValue

        if let airingStart = json["airing_start"].string {
            publishingStart = airingStart //anime
        } else {
            publishingStart = json["publishing_start"].stringValue //manga
        }

        if let airingEnd = json["airing_end"].string {
            publishingEnd = airingEnd //anime
        } else {
            publishingEnd = json["publishing_end"].stringValue //manga
        }
        
        volumes = json["volumes"].intValue
    }
}
