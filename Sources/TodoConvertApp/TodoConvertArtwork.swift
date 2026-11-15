import AppKit

/// Shared vector artwork: the app, menu bar, installer icon and brand exports
/// all draw the same Todo Convert mark — a rounded tile with two conversion arrows.
enum TodoConvertArtwork {
    // Brand colors. Change these three to re-colour every icon in the app.
    static let tileTop=NSColor(srgbRed:0.17,green:0.36,blue:0.98,alpha:1)
    static let tileBottom=NSColor(srgbRed:0.42,green:0.24,blue:0.92,alpha:1)
    static let accent=NSColor(srgbRed:1.00,green:0.62,blue:0.20,alpha:1)
    static let gold=accent
    static let ink=NSColor(srgbRed:0.10,green:0.12,blue:0.30,alpha:1)
    static func tilePath()->CGPath {
        CGPath(roundedRect:CGRect(x:0.08,y:0.08,width:0.84,height:0.84),cornerWidth:0.21,cornerHeight:0.21,transform:nil)
    }
    /// One arrow arc around the centre plus its arrow head, in the unit square (y down).
    static func addArrow(_ c:CGContext,from start:CGFloat,to end:CGFloat,radius r:CGFloat,width w:CGFloat) {
        let center=CGPoint(x:0.5,y:0.5)
        c.setLineWidth(w);c.setLineCap(.round)
        c.addArc(center:center,radius:r,startAngle:start,endAngle:end,clockwise:false);c.strokePath()
        let point=CGPoint(x:center.x+r*cos(end),y:center.y+r*sin(end))
        let tangent=CGPoint(x:-sin(end),y:cos(end)),normal=CGPoint(x:cos(end),y:sin(end))
        let head=w*1.25
        c.move(to:CGPoint(x:point.x+tangent.x*head*1.1,y:point.y+tangent.y*head*1.1))
        c.addLine(to:CGPoint(x:point.x+normal.x*head-tangent.x*head*0.35,y:point.y+normal.y*head-tangent.y*head*0.35))
        c.addLine(to:CGPoint(x:point.x-normal.x*head-tangent.x*head*0.35,y:point.y-normal.y*head-tangent.y*head*0.35))
        c.closePath();c.fillPath()
    }
    static func drawArrows(_ c:CGContext,color:NSColor,radius:CGFloat,width:CGFloat) {
        c.setStrokeColor(color.cgColor);c.setFillColor(color.cgColor)
        addArrow(c,from:CGFloat.pi*1.08,to:CGFloat.pi*1.80,radius:radius,width:width)
        addArrow(c,from:CGFloat.pi*0.08,to:CGFloat.pi*0.80,radius:radius,width:width)
    }
    static func draw(in rect:NSRect,happy:Bool=false,monochrome:Bool=false) {
        guard let c=NSGraphicsContext.current?.cgContext else { return }
        c.saveGState();defer{c.restoreGState()}
        c.translateBy(x:rect.minX,y:rect.maxY);c.scaleBy(x:rect.width,y:-rect.height)
        if monochrome {
            drawArrows(c,color:.black,radius:0.30,width:0.11)
            return
        }
        c.saveGState();c.addPath(tilePath());c.clip()
        let colors=[tileTop.cgColor,tileBottom.cgColor] as CFArray
        let gradient=CGGradient(colorsSpace:CGColorSpace(name:CGColorSpace.sRGB),colors:colors,locations:[0,1])!
        c.drawLinearGradient(gradient,start:CGPoint(x:0.15,y:0.08),end:CGPoint(x:0.85,y:0.92),options:[.drawsBeforeStartLocation,.drawsAfterEndLocation])
        c.setFillColor(NSColor.white.withAlphaComponent(0.10).cgColor);c.fillEllipse(in:CGRect(x:-0.2,y:-0.55,width:1.4,height:1.0))
        c.restoreGState()
        drawArrows(c,color:.white,radius:0.22,width:0.075)
        c.setFillColor(accent.cgColor)
        let dot:CGFloat=happy ? 0.15:0.11
        c.fillEllipse(in:CGRect(x:0.5-dot/2,y:0.5-dot/2,width:dot,height:dot))
    }
    static func mark(size:CGFloat,happy:Bool=false)->NSImage {
        NSImage(size:NSSize(width:size,height:size),flipped:false) { rect in draw(in:rect,happy:happy);return true }
    }
    static func menuIcon(updateAvailable:Bool=false)->NSImage {
        let image=NSImage(size:NSSize(width:20,height:20),flipped:false) { rect in
            draw(in:rect.insetBy(dx:0.5,dy:0.5),monochrome:true)
            if updateAvailable { NSColor.black.setFill();NSBezierPath(ovalIn:NSRect(x:15,y:15,width:4,height:4)).fill() }
            return true
        }
        image.isTemplate=true;image.accessibilityDescription=updateAvailable ? "Todo Convert update available":"Todo Convert";return image
    }
}
