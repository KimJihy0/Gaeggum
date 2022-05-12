//
//  GitHub.swift
//  Grass
//
//  Created by Jihyo on 2022/04/19.
//

import UIKit
import SwiftSoup
import SwiftUI

public struct Contribution {
    let date: Date
    let level: Level
    enum Level: Int, CaseIterable {
        case zero, first, second, third, fourth
        var color: Color {
            switch self {
            case .zero: return .emptyTile
            case .first: return .greenLevel1
            case .second: return .greenLevel2
            case .third: return .greenLevel3
            case .fourth: return .greenLevel4
            }
        }
    }
}

func contribution(from htmlElement: Element) throws -> Contribution? {
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    let dataDate = try htmlElement.attr("data-date")
    let dataLevel = try htmlElement.attr("data-level")

    guard let level = Int(dataLevel),
          let date = dateFormatter.date(from: dataDate)
    else { return nil }

    return Contribution(date: date, level: Contribution.Level(rawValue: level) ?? .zero)
}

func getContributions(of username: String) throws -> [Contribution] {
    guard let url = URL(string: "https://github.com/users/\(username)/contributions") else { throw URLError(.badURL) }
    let html = try String(contentsOf: url, encoding: .utf8)
    let document = try SwiftSoup.parse(html)
    let contributions = try document.select("rect").compactMap(contribution)
    return contributions
}

func getColors(of username: String) -> [[Color]] {
    let contributions = try! getContributions(of: username)
    let lastDate = contributions.last?.date // 원래 guard 이썼으(아마 커밋이 아예 없는 인원?)
    let tilesCount = 7 * 20 - (7 - Calendar.current.component(.weekday, from: lastDate!))
    let levels = contributions.suffix(tilesCount).map(\.level).chunked(into: 7)
    let colors = levels.map { $0.map(\.color) }
    return colors
}

