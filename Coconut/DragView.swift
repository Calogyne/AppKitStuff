
import Cocoa
import QuartzCore
import Darwin

class DragView : NSView {
    required init?(coder _coder: NSCoder) { super.init(coder: _coder) }
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        self.wantsLayer = true
        self.layer?.addSublayer(sublayer)
        
    }
    
    override var frame : NSRect {
        didSet {
            let midX = self.frame.midX,
                midY = self.frame.midY
            self.sublayer.position = CGPoint(x: midX, y: midY)
        }
    }
    
    
    var sublayer : Sublayer = {
        let l = Sublayer()
        // Bounds: Canvas exposed
        l.bounds = CGRect(x: 0.0, y: 0.0, width: 200, height: 200)
        // Anchor Point: where the layer's coordinate is based on
        l.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return l
    }()
    
    var angle : CGFloat { return atan2(offset.y, offset.x) }
    
    var offset : CGPoint = CGPoint.zero
    
    var newPosition : CGPoint {
        return CGPoint(x: frame.midX + cos(angle) * sqrt(offset.abs) * 10,
                       y: frame.midY + sin(angle) * sqrt(offset.abs) * 10)
    }
    
    var isMouseInDraggingZone : Bool = false
    override func mouseDown(with event: NSEvent) {
        isMouseInDraggingZone = sublayer.hitTest(event.locationInWindow) === sublayer
    }
    
    override func mouseDragged(with event: NSEvent) {
        if isMouseInDraggingZone {
            offset += (event.deltaX, -event.deltaY)
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.033)
            sublayer.position = newPosition
            CATransaction.commit()
        }
    }

    override func mouseUp(with event: NSEvent) {
        Swift.print(newPosition)
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.5)
        sublayer.position = CGPoint(x: frame.midX, y: frame.midY)
        CATransaction.commit()
        offset = CGPoint.zero
        isMouseInDraggingZone = false
    }
    
    override func draw(_ dirtyRect: NSRect) {
        let ctx = NSGraphicsContext.current!.cgContext
        
        let strokeColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        ctx.drawDashLine(rect: frame, color: strokeColor)
        ctx.drawTextAt("Base Layer Bound/Frame",
                       x: 20, y: frame.size.height - 30,
                       font: "Helvetica Neue Bold", size: 13,
                       color: strokeColor)
    }
}
