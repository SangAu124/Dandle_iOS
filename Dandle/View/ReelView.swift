//
//  ReelView.swift
//  Dandle
//
//  Created by dev상금 on 6/12/24.
//

import SwiftUI
import AVKit

struct ReelView: View {
  @Binding var reel: Reel
  @Binding var likedCounter: [Like]
  var size: CGSize
  var safeArea: EdgeInsets
  
  /// View Properties
  @State private var player: AVPlayer?
  @State private var looper: AVPlayerLooper?
  var body: some View {
    GeometryReader {
      let rect = $0.frame(in: .scrollView(axis: .vertical))
      /// Custom Video Player View
      CustomVideoPlayer(player: $player)
      /// Offset Updates
        .preference(key: OffsetKey.self, value: rect)
        .onPreferenceChange(OffsetKey.self, perform: { value in
          playPause(value)
        })
        .overlay(alignment: .bottom, content: {
          ReelDetailView()
        })
        /// Double Tap Like Animation
        .onTapGesture(count: 2, perform: { position in
          let id = UUID()
          likedCounter.append(.init(id: id, tappedRect: position, isAnimated: false))
          /// Animating Like
          withAnimation(.snappy(duration: 1.2), completionCriteria: .logicallyComplete) {
            if let index = likedCounter.firstIndex(where: {$0.id == id}) {
              likedCounter[index].isAnimated = true
            }
          } completion: {
            /// Removing Like, Once it's Finished
            likedCounter.removeAll(where: { $0.id == id })
          }
          
          /// Liking the Reel
          reel.isLiked = true
        })
        /// Creating Player
        .onAppear {
          guard player == nil else { return }
          guard let bundleID = Bundle.main.path(forResource: reel.videoID, ofType: "mp4") else { return }
          let videoURL = URL(filePath: bundleID)
//          let videoURL = URL(string: "https://www.pexels.com/video/woman-in-a-beach-8362273/")!
          
          let playerItem = AVPlayerItem(url: videoURL)
          let queue = AVQueuePlayer(playerItem: playerItem)
          looper = AVPlayerLooper(player: queue, templateItem: playerItem)
          
          player = queue
        }
        /// Clearing Player
        .onDisappear {
          player = nil
        }
    }
  }
  /// Play/Pause Action
  func playPause(_ rect: CGRect) {
    if -rect.minY < (rect.height * 0.5) && rect.minY < (rect.height * 0.5) {
      player?.play()
    } else {
      player?.pause()
    }
    
    if rect.minY >= size.height || -rect.minY >= size.height {
      player?.seek(to: .zero)
    }
  }
  
  /// Reel Details & Contols
  @ViewBuilder
  func ReelDetailView() -> some View {
    HStack(alignment: .bottom, spacing: 10) {
      VStack(alignment: .leading, spacing: 8) {
        HStack(spacing: 10) {
          Image(systemName: "person.circle.fill")
            .font(.largeTitle)
          
          Text(reel.authorName)
            .font(.callout)
            .lineLimit(1)
        }
        .foregroundStyle(.white)
        
        Text("블라블라 왈라왈라 쌀라쌀라 쑬렁쑬렁 호랑호랑 풀렁풀렁 왔다리 갔다리 블라블라 왈라왈라 쌀라쌀라 쑬렁쑬렁 호랑호랑 풀렁풀렁 왔다리 갔다리")
          .font(.caption)
          .foregroundStyle(.secondary)
          .lineLimit(2)
          .clipped()
      }
      
      Spacer(minLength: 0)
      
      /// Control View
      VStack(spacing: 35) {
        Button("", systemImage: reel.isLiked ? "suit.heart.fill" : "suit.heart") {
          reel.isLiked.toggle()
        }
        .symbolEffect(.bounce, value: reel.isLiked)
        .foregroundStyle(reel.isLiked ? .red : .white)
        
        Button("", systemImage: "message") {}
        Button("", systemImage: "paperplane") {}
        Button("", systemImage: "ellipsis") {}
      }
      .font(.title2)
      .foregroundStyle(.white)
    }
    .padding(.leading, 15)
    .padding(.trailing, 10)
    .padding(.bottom, safeArea.bottom + 15)
  }
}


#Preview {
    ContentView()
}
