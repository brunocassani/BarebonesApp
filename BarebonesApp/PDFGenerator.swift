//
//  PDFGenerator.swift
//  BarebonesApp
//
//  Created by Bruno Cassani on 7/12/24.
//

import Foundation
import PDFKit

class PDFGenerator {
    var climate: ClimateData
    var arrow: ArrowData
    var bow: BowData
    var sight: SightData
    
    init(climate: ClimateData, arrow: ArrowData, bow: BowData, sight: SightData) {
        self.climate = climate
        self.arrow = arrow
        self.bow = bow
        self.sight = sight
    }
    
    func createPDF(fileName: String) {
        // Create PDF document and page
        let pdfDocument = PDFDocument()
        let pdfPage = PDFPage()
        
        let pageBounds = CGRect(x: 0, y: 0, width: 612, height: 792) // Letter size
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw setup specs
        drawInfo(context: context, setupData: generateSetupData())
        
        // Draw scale check
        drawScales(context: context)
        
        // Add drawings to PDF page
        pdfPage.setBounds(pageBounds, for: .mediaBox)
        pdfDocument.insert(pdfPage, at: 0)
        
        // Save PDF document to file
        if let data = pdfDocument.dataRepresentation() {
            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            try? data.write(to: fileURL)
            print("PDF saved at: \(fileURL)")
        }
    }
    
    func generateSetupData() -> [String: Any] {
        return [
            "Sight height": bow.peepToArrow,
            "Sight radius": bow.peepToPin,
            "Arrow weight": arrow.weight,
            "Arrow length": arrow.length,
            "Arrow diameter": arrow.diameter,
            "Arrow speed": arrow.speed,
            "Range 1": sight.range1,
            "Range 2": sight.range2,
            "Difference of 1 & 2": sight.distanceBetween1And2,
            "Max range": sight.maxRange,
            "Min range": sight.minRange
        ]
    }
    
    func drawInfo(context: CGContext, setupData: [String: Any]) {
        // Define the top left position and dimensions of the table
        let tableX: CGFloat = 36
        let tableY: CGFloat = 750
        let tableWidth: CGFloat = 300
        let tableHeight: CGFloat = 220
        let rowHeight: CGFloat = 20
        let colWidth: CGFloat = tableWidth / 3
        
        // Add Setup Specs header
        context.setFontSize(12)
        context.textPosition = CGPoint(x: tableX, y: tableY + 10)
        context.showText("Setup Specs")
        
        let labels = [
            "Sight height",
            "Sight radius",
            "Arrow weight",
            "Arrow length",
            "Arrow diameter",
            "Arrow speed",
            "Range 1",
            "Range 2",
            "Difference of 1 & 2",
            "Max range",
            "Min range"
        ]
        
        // Draw table grid
        context.setLineWidth(1.0)
        for i in 0...labels.count {
            let y = tableY - CGFloat(i) * rowHeight
            context.move(to: CGPoint(x: tableX, y: y))
            context.addLine(to: CGPoint(x: tableX + tableWidth, y: y))
            context.strokePath()
        }
        for i in 0...3 {
            let x = tableX + CGFloat(i) * colWidth
            context.move(to: CGPoint(x: x, y: tableY))
            context.addLine(to: CGPoint(x: x, y: tableY - tableHeight))
            context.strokePath()
        }
        
        // Set font for text
        context.setFontSize(10)
        
        // Populate the table with labels, actual values, and units
        for (i, label) in labels.enumerated() {
            let y = tableY - CGFloat(i + 1) * rowHeight
            context.textPosition = CGPoint(x: tableX + 5, y: y + 5)
            context.showText(label)
            if let value = setupData[label] as? Double {
                context.textPosition = CGPoint(x: tableX + colWidth + 5, y: y + 5)
                context.showText("\(value)")
            }
            // Add unit information if needed
        }
    }
    
    func drawScales(context: CGContext) {
        let padding: CGFloat = 36
        let rectWidth: CGFloat = 3.375 * 72
        let rectHeight: CGFloat = 2.125 * 72
        let cornerRadius: CGFloat = 10
        let rectX: CGFloat = padding
        let rectY: CGFloat = padding
        let circleDiameter: CGFloat = 0.955 * 72
        let circleX: CGFloat = rectX + (rectWidth - circleDiameter) / 2
        let circleY: CGFloat = rectY + (rectHeight - circleDiameter) / 2
        
        // Add Scale Check header
        context.setFontSize(12)
        context.textPosition = CGPoint(x: rectX, y: rectY + rectHeight + 15)
        context.showText("Scale Check")
        
        // Draw rounded rectangle
        context.addRoundedRect(in: CGRect(x: rectX, y: rectY, width: rectWidth, height: rectHeight), cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        context.strokePath()
        
        // Draw circle
        context.addEllipse(in: CGRect(x: circleX, y: circleY, width: circleDiameter, height: circleDiameter))
        context.strokePath()
        
        // Add text inside the rectangle
        context.setFontSize(10)
        let textRectX = rectX + rectWidth / 2
        let textRectY = rectY + rectHeight / 2 + 50
        context.textPosition = CGPoint(x: textRectX, y: textRectY)
        context.showText("Credit card")
        
        // Add text inside the circle
        let textCircleX = circleX + circleDiameter / 2
        let textCircleY = circleY + circleDiameter / 2
        context.textPosition = CGPoint(x: textCircleX, y: textCircleY)
        context.showText("US Quarter")
    }
}

extension CGContext {
    func setFontSize(_ fontSize: CGFloat) {
        let font = CTFontCreateWithName("Helvetica" as CFString, fontSize, nil)
        self.setFont(CTFontCopyGraphicsFont(font, nil))
    }
    
    func showText(_ text: String) {
        let attributedString = NSAttributedString(string: text, attributes: [.font: CTFontCreateWithName("Helvetica" as CFString, 12, nil)])
        let line = CTLineCreateWithAttributedString(attributedString)
        CTLineDraw(line, self)
    }
    
    func addRoundedRect(in rect: CGRect, cornerWidth: CGFloat, cornerHeight: CGFloat) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerWidth, height: cornerHeight))
        self.addPath(path.cgPath)
    }
}
