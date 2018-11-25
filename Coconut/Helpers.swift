
import CoreGraphics
import AppKit
import MetalKit


infix operator |>: Piping
precedencegroup Piping { lowerThan: AdditionPrecedence associativity: left }
func |> <T, S>(left: T, right: (T) -> S) -> S {
    return right(left)
}

extension CGContext {
    func drawTextAt(_ content: String, x: CGFloat, y: CGFloat, font: String, size: CGFloat, color: CGColor) {
        self.saveGState()
        let _attributes : [NSAttributedStringKey : Any]? =
            [ NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): NSFont(name: font, size: size)!,
              NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): NSColor(cgColor: color)! ]
        
        let string = NSAttributedString(string: content, attributes: _attributes)
        let line = CTLineCreateWithAttributedString(string)
        self.textPosition = CGPoint(x: x, y: y)
        CTLineDraw(line, self)
        self.restoreGState()
    }
    
    func drawDashLine(rect: CGRect, color: CGColor) {
        let lineWidth : CGFloat = 3.0
        self.setLineWidth(lineWidth)
        self.setLineDash(phase: 1, lengths: [20, 6])
        color |> self.setStrokeColor
        
        // Prettify
        let prettyFrame =
            CGRect(x: lineWidth, y: lineWidth,
                   width: rect.size.width - 2 * lineWidth,
                   height: rect.size.height - 2 * lineWidth)
        CGPath(roundedRect: prettyFrame, cornerWidth: 20, cornerHeight: 20, transform: nil)
            |> self.addPath
        self.strokePath()
    }
}

extension CGPoint {
    func offsetBy(x _x: CGFloat, y _y: CGFloat) -> CGPoint {
        let newX = self.x + _x,
            newY = self.y + _y
        return CGPoint(x: newX, y: newY)
    }
    
    static func +=(left: inout CGPoint, right: (CGFloat, CGFloat)) {
        left = left.offsetBy(x: right.0, y: right.1)
    }
    
    static func -=(left: inout CGPoint, right: (CGFloat, CGFloat)) {
        left = left.offsetBy(x: -right.0, y: -right.1)
    }
    
    var abs : CGFloat { return sqrt(self.x * self.x + self.y * self.y) }
}
