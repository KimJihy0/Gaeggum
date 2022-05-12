//
//  Boj.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/12.
//

import Foundation
import UIKit

func toHtml(_ scale: CGFloat, _ handle: String) -> String{
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
