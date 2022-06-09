//
//  Boj.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/12.
//

import Foundation
import SwiftUI
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

struct Tier {
    
    let roughTier: RoughTier
    let detailTier: DetailTier
    let rating: Int
    
    enum RoughTier: String {
        case Master, Ruby, Diamond, Platinum, Gold, Silver, Bronze, Null;
        var color: Color {
            switch self {
            case .Null: return .emptyTile
            case .Bronze: return .brown
            case .Silver: return .gray
            case .Gold: return .yellow
            case .Platinum: return .green
            case .Diamond: return .blue
            case .Ruby: return .red
            case .Master: return .purple
            }
        }
    }

    enum DetailTier: String {
        case I, II, III, IV, V;
    }
    
    static let tiers: [Tier] = [
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
        Tier(roughTier: .Master, detailTier: .I, rating: 10000)
    ]
    
    init(roughTier: RoughTier, detailTier: DetailTier, rating: Int) {
        self.roughTier = roughTier
        self.detailTier = detailTier
        self.rating = rating
    }
    
    init(value: Int) {
        self = Tier.tiers[value]
    }
    
    func toString() -> String {
        return roughTier.rawValue + " " + detailTier.rawValue
    }
}

struct ProblemStatView: View {
    let colors: [[Color]]
    
    public var body: some View {
        GridStack(rows: 7, columns: 15, spacing: 3.0) { row, column in
            if let color = colors.element(at: row)?.element(at: column) {
                color.tileStyle()
            } else {
                Color.clear
            }
        }
    }
    
    public init(username: String) {
        self.colors = ProblemStat.getColors(of: username)
    }
}

public struct ProblemStat: Decodable {
    var level: Int
    var solved: Int
    var tier: Tier {
        return Tier(value: level)
    }
    
    static func getColors(of username: String) -> [[Color]] {
        var tiers : [Tier] = []
        let url = URL(string: "https://solved.ac/api/v3/user/problem_stats?handle=hyo0508")!
        let data = try! String(contentsOf: url).data(using: .utf8)!
        var stats = try! JSONDecoder().decode([ProblemStat].self, from: data)
        
        stats.reverse()
        
        for stat in stats {
            for _ in 0..<stat.solved {
                tiers.append(Tier(value: stat.level))
            }
        }
        return tiers.prefix(140).map(\.roughTier.color).chunked(into: 7)
    }
}
