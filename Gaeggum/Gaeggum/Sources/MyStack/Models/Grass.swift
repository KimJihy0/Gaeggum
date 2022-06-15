//
//  GitHub.swift
//  Grass
//
//  Created by Jihyo on 2022/04/19.
//

import UIKit
import SwiftSoup
import SwiftUI

struct GrassView : View {
    let colors: [[Color]]
    
    public var body: some View {
        HorizontalGridStack() { row, column in
            if let color = colors.element(at: row)?.element(at: column) {
                color.tileStyle()
            } else {
                Color.clear
            }
        }
    }
    
    public init(username: String) {
        self.colors = Contribution.getColors(of: username)
    }
}

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
    
    static func isValid(gitUsername: String) -> Bool {
        guard let url = URL(string: "https://api.github.com/users/\(gitUsername)") else {
            return false
        }
        let html = try? String(contentsOf: url, encoding: .utf8)
        return html != nil
    }

    static func contribution(from htmlElement: Element) throws -> Contribution? {
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

    static func getContributions(of username: String) throws -> [Contribution] {
        guard let url = URL(string: "https://github.com/users/\(username)/contributions") else { throw URLError(.badURL) }
        let html = try String(contentsOf: url, encoding: .utf8)
        let document = try SwiftSoup.parse(html)
        let contributions = try document.select("rect").compactMap(contribution)
        return contributions
    }

    static func getColors(of username: String) -> [[Color]] {
        guard let contributions = try? getContributions(of: username) else { return []}
        let lastDate = contributions.last?.date
        let tilesCount = 7 * 20 - (7 - Calendar.current.component(.weekday, from: lastDate!))
        let levels = contributions.suffix(tilesCount).map(\.level).chunked(into: 7)
        let colors = levels.map { $0.map(\.color) }
        return colors
    }

}

struct HorizontalGridStack<Content: View>: View {
    
    let content: (Int, Int) -> Content
    
    var body: some View {
        HStack(spacing: 3.0) {
            ForEach(0 ..< 20, id: \.self) { row in
                VStack(spacing: 3.0) {
                    ForEach(0 ..< 7, id: \.self) { column in
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


struct Tile: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(RoundedRectangle(cornerRadius: 2, style: .continuous).stroke(Color.tileBorder, lineWidth: 1))
            .cornerRadius(2)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    func element(at index: Int) -> Element? {
        index >= 0 && index < endIndex ? self[index] : nil
    }
}

extension Color {
    static var tileBorder: Color {
        Color(.init { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.329, green: 0.329, blue: 0.345, alpha: 0.2)
                : UIColor(red: 0.106, green: 0.122, blue: 0.137, alpha: 0.04)
        })
    }
    static var emptyTile: Color {
        Color(.init { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor.quaternarySystemFill
                : UIColor(red: 0.922, green: 0.929, blue: 0.941, alpha: 1.0)
        })
    }
    static let greenLevel1 = Color("GreenLevel1")
    static let greenLevel2 = Color("GreenLevel2")
    static let greenLevel3 = Color("GreenLevel3")
    static let greenLevel4 = Color("GreenLevel4")
}

extension View {
    func tileStyle() -> some View {
        modifier(Tile())
    }
}
