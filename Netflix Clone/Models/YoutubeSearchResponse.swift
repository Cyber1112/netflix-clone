//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Khakim Zhumagaliyev on 30.08.2022.
//

import Foundation

struct YoutubeSearchResultsResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
