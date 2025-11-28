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

    // ---- КЛАВИАТУРА ----
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
