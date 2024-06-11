//
//  CustomVideoPlayer.swift
//  Dandle
//
//  Created by dev상금 on 6/12/24.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
  @Binding var player: AVPlayer?
  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let controller = AVPlayerViewController()
    controller.player = player
    controller.videoGravity = .resizeAspectFill
    controller.showsPlaybackControls = false
    
    return controller
  }
  
  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    /// Updating Conroller
    
    uiViewController.player = player
  }
}
