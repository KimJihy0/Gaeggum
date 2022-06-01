//
//  Boj.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/12.
//

import Foundation
import UIKit

struct BojStat: Codable {
    var solvedCount: Int
    var tier: Int
    var rating: Int
    
    static func bojStatHtml(_ scale: CGFloat, _ handle: String) -> String {
        return """
                <html>
                    <head>
                        <meta name="viewport" content="width=device-width, initial-scale=\(scale), maximum-scale=\(scale), minimum-scale=\(scale), user-scalable=0">
                    </head>
                    <body>
                        <img src="https://github-readme-solvedac.hyp3rflow.vercel.app/api/?handle=\(handle)">
                    </body>
                </html>
                """
    }
}

func isValid(handle: String) -> Bool {
    guard let url = URL(string: "https://solved.ac/api/v3/user/show?handle=\(handle)") else {
        return false
    }
    let html = try? String(contentsOf: url, encoding: .utf8)
    return html != nil
}

func isValid(gitUsername: String) -> Bool {
    guard let url = URL(string: "https://api.github.com/users/\(gitUsername)") else {
        return false
    }
    let html = try? String(contentsOf: url, encoding: .utf8)
    return html != nil
}

struct Tier: Codable {
    
    let roughTier: RoughTier
    let detailTier: DetailTier
    let rating: Int
    
    enum RoughTier: Codable {
        case Master, Ruby, Diamond, Platinum, Gold, Silver, Bronze, Null;
    }

    enum DetailTier: Codable {
        case I, II, III, IV, V;
    }
    
    static func tiers() -> [Tier] {
        return [
            Tier(roughTier: .Null, detailTier: .I, rating: 0),
            Tier(roughTier: .Bronze, detailTier: .V, rating: 30),
            Tier(roughTier: .Bronze, detailTier: .IV, rating: 60),
            Tier(roughTier: .Bronze, detailTier: .III, rating: 90),
            Tier(roughTier: .Bronze, detailTier: .II, rating: 120),
            Tier(roughTier: .Bronze, detailTier: .I, rating: 150),
            Tier(roughTier: .Silver, detailTier: .V, rating: 200),
            Tier(roughTier: .Silver, detailTier: .IV, rating: 300),
            Tier(roughTier: .Silver, detailTier: .III, rating: 400),
            Tier(roughTier: .Silver, detailTier: .II, rating: 500),
            Tier(roughTier: .Silver, detailTier: .I, rating: 650),
            Tier(roughTier: .Gold, detailTier: .V, rating: 800),
            Tier(roughTier: .Gold, detailTier: .IV, rating: 950),
            Tier(roughTier: .Gold, detailTier: .III, rating: 1100),
            Tier(roughTier: .Gold, detailTier: .II, rating: 1250),
            Tier(roughTier: .Gold, detailTier: .I, rating: 1400),
            Tier(roughTier: .Platinum, detailTier: .V, rating: 1600),
            Tier(roughTier: .Platinum, detailTier: .IV, rating: 1750),
            Tier(roughTier: .Platinum, detailTier: .III, rating: 1900),
            Tier(roughTier: .Platinum, detailTier: .II, rating: 2000),
            Tier(roughTier: .Platinum, detailTier: .I, rating: 2100),
            Tier(roughTier: .Diamond, detailTier: .V, rating: 2200),
            Tier(roughTier: .Diamond, detailTier: .IV, rating: 2300),
            Tier(roughTier: .Diamond, detailTier: .III, rating: 2400),
            Tier(roughTier: .Diamond, detailTier: .II, rating: 2500),
            Tier(roughTier: .Diamond, detailTier: .I, rating: 2600),
            Tier(roughTier: .Ruby, detailTier: .V, rating: 2700),
            Tier(roughTier: .Ruby, detailTier: .IV, rating: 2800),
            Tier(roughTier: .Ruby, detailTier: .III, rating: 2850),
            Tier(roughTier: .Ruby, detailTier: .II, rating: 2900),
            Tier(roughTier: .Ruby, detailTier: .I, rating: 2950),
            Tier(roughTier: .Master, detailTier: .I, rating: 3000),
        ]
    }
    
    init(roughTier: RoughTier, detailTier: DetailTier, rating: Int) {
        self.roughTier = roughTier
        self.detailTier = detailTier
        self.rating = rating
    }
    
    init(value: Int) {
        self = Tier.tiers()[value]
    }
}
