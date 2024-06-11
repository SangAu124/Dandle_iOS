//
//  Like.swift
//  Dandle
//
//  Created by dev상금 on 6/12/24.
//

import SwiftUI

struct Like: Identifiable {
    var id: UUID = .init()
    var tappedRect: CGPoint = .zero
    var isAnimated: Bool = false
}
