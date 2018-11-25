
import Cocoa

let app = NSApplication.shared
let mainWin = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 750, height: 500),
                       styleMask: NSWindow.StyleMask.titled,
                       backing: .buffered, defer: false)

mainWin.title = "Coconut, Cocoa without Storyboard"
mainWin.cascadeTopLeft(from: NSPoint(x: 400, y: 400))
mainWin.makeKeyAndOrderFront(nil)
mainWin.contentView = DragView()
app.run()

let 💩 = "shit"

