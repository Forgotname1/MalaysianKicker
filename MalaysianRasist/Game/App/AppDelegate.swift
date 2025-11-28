import Cocoa
import SpriteKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window = NSWindow(
        contentRect: NSRect(x: 0, y: 0, width: 1280, height: 720),
        styleMask: [.titled, .closable, .resizable, .miniaturizable],
        backing: .buffered,
        defer: false
    )

    func applicationDidFinishLaunching(_ notification: Notification) {

        let screenFrame = NSScreen.main!.frame

        window = NSWindow(
            contentRect: screenFrame,
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        let viewController = GameViewController()
        window.contentViewController = viewController
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        window.title = "Malaysian Rasist"
    }
}
