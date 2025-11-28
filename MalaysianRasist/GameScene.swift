import SpriteKit

class GameScene: SKScene {

    private var ilya: SKSpriteNode!
    private var walkFrames: [SKTexture] = []

    override func didMove(to view: SKView) {

        // ---- ФОН ----
        let bg = SKSpriteNode(imageNamed: "background")
        bg.position = CGPoint(x: frame.midX, y: frame.midY)
        bg.zPosition = -10
        bg.size = self.size
        addChild(bg)

        // ---- ЗАГРУЗКА СПРАЙТОВ ----
        for i in 1...13 {
            let name = String(format: "walk_%02d", i)
            walkFrames.append(SKTexture(imageNamed: name))
        }

        // ---- ПЕРСОНАЖ ----
        ilya = SKSpriteNode(texture: walkFrames[0])
        ilya.position = CGPoint(x: frame.midX, y: frame.midY)
        ilya.setScale(0.35)   // Было 0.7 → в 2 раза меньше
        ilya.zPosition = 10
        addChild(ilya)
    }

    // ---- СТАРТ АНИМАЦИИ ----
    func startWalkAnimation() {
        if ilya.action(forKey: "walk") == nil {
            let animation = SKAction.repeatForever(
                .animate(with: walkFrames, timePerFrame: 0.13)  // медленнее на 30%
            )
            ilya.run(animation, withKey: "walk")
        }
    }

    // ---- ОСТАНОВКА АНИМАЦИИ ----
    func stopWalkAnimation() {
        ilya.removeAction(forKey: "walk")
        ilya.texture = walkFrames[0]   // Возвращаем в стойку
    }

#if os(iOS)
    // ---- ТАЧ-УПРАВЛЕНИЕ (iOS) ----
    private var lastTouchLocation: CGPoint?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        lastTouchLocation = touch.location(in: self)
        startWalkAnimation() // стартуем анимацию при касании
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let current = touch.location(in: self)
        let previous = touch.previousLocation(in: self)
        let dx = current.x - previous.x
        let dy = current.y - previous.y

        // Определяем направление преобладающего движения
        if abs(dx) > abs(dy) {
            if dx > 0 {
                moveRight()
            } else {
                moveLeft()
            }
        } else {
            if dy > 0 {
                moveUp()
            } else {
                moveDown()
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopWalkAnimation() // отпустил — стоит
        lastTouchLocation = nil
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopWalkAnimation()
        lastTouchLocation = nil
    }
#endif

#if os(macOS)
    // ---- КЛАВИАТУРА (macOS) ----
    override var acceptsFirstResponder: Bool { true }

    override func keyDown(with event: NSEvent) {
        startWalkAnimation()   // анимация только когда нажал кнопку
        switch event.keyCode {
        case 123: moveLeft()
        case 124: moveRight()
        case 125: moveDown()
        case 126: moveUp()
        default: break
        }
    }

    override func keyUp(with event: NSEvent) {
        stopWalkAnimation()    // отпустил — стоит
    }
#endif

    // ---- ДВИЖЕНИЕ ----
    private func moveLeft() {
        ilya.xScale = -abs(ilya.xScale)
        ilya.run(SKAction.moveBy(x: -14, y: 0, duration: 0.15))  // 30% медленнее
    }

    private func moveRight() {
        ilya.xScale = abs(ilya.xScale)
        ilya.run(SKAction.moveBy(x: 14, y: 0, duration: 0.15))
    }

    private func moveUp() {
        ilya.run(SKAction.moveBy(x: 0, y: 10, duration: 0.15))
    }

    private func moveDown() {
        ilya.run(SKAction.moveBy(x: 0, y: -10, duration: 0.15))
    }
}
