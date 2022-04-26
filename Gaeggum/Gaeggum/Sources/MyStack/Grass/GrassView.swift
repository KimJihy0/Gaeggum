//
//  GrassView.swift
//  Grass
//
//  Created by Jihyo on 2022/04/19.
//

import SwiftUI

struct GrassView : View {
    let colors: [[Color]]
    
    public var body: some View {
        GridStack(rows: 7, columns: 20, spacing: 3.0) { row, column in
            if let color = colors.element(at: row)?.element(at: column) {
                color.tileStyle()
            } else {
                Color.clear
            }
        }
    }
    
    public init(username: String) {
        self.colors = getColors(of: username)
    }
}
