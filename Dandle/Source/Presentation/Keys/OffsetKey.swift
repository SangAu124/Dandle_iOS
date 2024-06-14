//
//  OffsetKey.swift
//  Dandle
//
//  Created by dev상금 on 6/12/24.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
  static var defaultValue: CGRect = .zero
  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
    value = nextValue()
  }
}
