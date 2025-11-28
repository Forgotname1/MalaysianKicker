//
//  GameViewController.swift
//  MalaysianRasist
//
//  Created by Илья Моторов on 27/11/2568 BE.
//
import Cocoa
import SpriteKit

class GameViewController: NSViewController {

    override func loadView() {
        self.view = SKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill

        if let skView = view as? SKView {
            skView.presentScene(scene)

            skView.ignoresSiblingOrder = true
            skView.showsFPS = true
            skView.showsNodeCount = true
        }
    }
}
