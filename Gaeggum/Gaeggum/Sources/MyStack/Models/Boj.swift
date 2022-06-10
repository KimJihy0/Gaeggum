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
    
    static func isValid(handle: String) -> Bool {
        guard let url = URL(string: "https://solved.ac/api/v3/user/show?handle=\(handle)") else {
            return false
        }
        let html = try? String(contentsOf: url, encoding: .utf8)
        return html != nil
    }
}

struct Tier {
    let roughTier: RoughTier
    let detailTier: DetailTier
    let rating: Int
    
    enum RoughTier: String {
        case Master, Ruby, Diamond, Platinum, Gold, Silver, Bronze, Null;
        var color: Color {
            switch self {
            case .Null: return Color(rgb: 0x2d2d2d)
            case .Bronze: return Color(rgb: 0xad5600)
            case .Silver: return Color(rgb: 0x435f7a)
            case .Gold: return Color(rgb: 0xec9a00)
            case .Platinum: return Color(rgb: 0x27e2a4)
            case .Diamond: return Color(rgb: 0x00b4fc)
            case .Ruby: return Color(rgb: 0xff0062)
            case .Master: return .white
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
    let tiers: [[Tier]]
    
    public var body: some View {
        VerticalGridStack() { row, column in
            if let tier = tiers.element(at: row)?.element(at: column) {
                tier.roughTier.color.tierStyle(number: detailTierToNumber(tier: tier.detailTier))
            } else {
                Color.clear
            }
        }
    }
    
    public init(username: String) {
        self.tiers = ProblemStat.getColors(of: username)
    }
}

public struct ProblemStat: Decodable {
    var level: Int
    var solved: Int
    var tier: Tier {
        return Tier(value: level)
    }
    
    static func getColors(of username: String) -> [[Tier]] {
        var tiers : [Tier] = []
        let url = URL(string: "https://solved.ac/api/v3/user/problem_stats?handle=\(username)")!
        let data = try! String(contentsOf: url).data(using: .utf8)!
        var stats = try! JSONDecoder().decode([ProblemStat].self, from: data)
        
        stats.reverse()
        
        for stat in stats {
            for _ in 0..<stat.solved {
                tiers.append(Tier(value: stat.level))
            }
        }
        return Array(tiers.prefix(100)).chunked(into: 15)
    }
}

struct TierTile: ViewModifier {
    
    let number: Int
    
    func body(content: Content) -> some View {
        content
            .overlay(RoundedRectangle(cornerRadius: 2, style: .continuous).stroke(Color.tileBorder, lineWidth: 1))
            .cornerRadius(2)
            .overlay(Text(String(number)).font(.system(size: 14, weight: .black)).foregroundColor(.white))
    }
    
    init(number: Int) {
        self.number = number
    }
}

extension View {
    func tierStyle(number: Int) -> some View {
        modifier(TierTile(number: number))
    }
}

func detailTierToNumber(tier: Tier.DetailTier) -> Int {
    switch tier {
    case .I: return 1
    case .II: return 2
    case .III: return 3
    case .IV: return 4
    case .V: return 5
    }
}

struct VerticalGridStack<Content: View>: View {
    
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: 3.0) {
            ForEach(0 ..< 7, id: \.self) { row in
                HStack(spacing: 3.0) {
                    ForEach(0 ..< 15, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
    
    init(@ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.content = content
    }
}

extension Color {
    init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0)
   }

    init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
