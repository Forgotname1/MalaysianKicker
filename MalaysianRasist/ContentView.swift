import SwiftUI
import SpriteKit

struct ContentView: View {
    @State private var scene: SKScene = {
        let scene = GameScene(size: CGSize(width: 800, height: 600))
        scene.scaleMode = .resizeFill
        return scene
    }()

    var body: some View {
        GeometryReader { proxy in
            SpriteView(scene: scene, options: [.ignoresSiblingOrder])
                .onChange(of: proxy.size) { _, newSize in
                    scene.size = newSize
                }
                .ignoresSafeArea()
        }
        
    }
}

#Preview {
    ContentView()
}
