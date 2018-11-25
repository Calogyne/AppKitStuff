
import QuartzCore
import Cocoa
import CoreGraphics

class Sublayer : CALayer {
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    override init(layer _layer: Any) { super.init(layer: _layer) }
    override init() {
        super.init()
        self.contentsScale = 2.0
        self.setNeedsDisplay()
    }
    var x: QuartzCore.CALayer? = nil
    var strokeColor = CGColor(red:1.00, green:0.66, blue:0.00, alpha:1.0)
    
    override func draw(in ctx: CGContext) {
        ctx.drawDashLine(rect: self.frame, color: strokeColor)
        ctx.drawTextAt("Sublayer Frame",
                       x: 20, y: self.frame.size.height - 30,
                       font: "Helvetica Neue Bold", size: 13,
                       color: strokeColor)
    }
}
