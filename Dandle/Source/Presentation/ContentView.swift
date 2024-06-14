//
//  ContentView.swift
//  Dandle
//
//  Created by 김상금 on 2023/10/04.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    GeometryReader {
      let size = $0.size
      let safeArea = $0.safeAreaInsets
      
      Home(size: size, safeArea: safeArea)
        .ignoresSafeArea(.container, edges: .all)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
