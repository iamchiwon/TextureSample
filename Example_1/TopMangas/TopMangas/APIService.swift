//
//  APIService.swift
//  TopMangas
//
//  Created by iamchiwon on 2018. 8. 16..
//  Copyright © 2018년 iamchiwon. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIService {

    static func topManga() -> (Int, (([Manga]) -> ())?) -> Void {
        let base = "https://api.jikan.moe/top/manga"
        return { page, completed in
            return get(base: base, page: page, completed: completed)
        }
    }

    static func topAnime() -> (Int, (([Manga]) -> ())?) -> Void {
        let base = "https://api.jikan.moe/top/anime"
        return { page, completed in
            return get(base: base, page: page, completed: completed)
        }
    }

    private static func get(base: String, page: Int, completed: (([Manga]) -> ())? = nil) -> Void {
        let url = URL(string: "\(base)/\(page)")!
        let session = URLSession.shared.dataTask(with: url, completionHandler: { data, res, err in
            if err != nil {
                completed?([])
                return
            }

            guard let data = data else {
                completed?([])
                return
            }

            let mangas = JSON(data)["top"].arrayValue.map({ Manga(json: $0) })
            completed?(mangas)
        })
        session.resume()
    }

}
