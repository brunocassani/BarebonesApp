import SwiftUI
import PDFKit

struct ContentView: View {
    @ObservedObject var climate = ClimateData()
    @ObservedObject var arrow = ArrowData()
    @ObservedObject var bow = BowData()
    @ObservedObject var sight = SightData()
    
    @State private var showPDF = false
    @State private var pdfURL: URL?
    
    var body: some View {
        VStack {
            Button("Generate PDF") {
                generatePDF()
            }
            .padding()
            
            if let url = pdfURL {
                NavigationLink(destination: PDFViewer(url: url), isActive: $showPDF) {
                    EmptyView()
                }
            }
        }
        .navigationTitle("PDF Generator")
    }
    
    func generatePDF() {
        let generator = PDFGenerator(climate: climate, arrow: arrow, bow: bow, sight: sight)
        let fileName = "generated.pdf"
        generator.createPDF(fileName: fileName)
        
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        pdfURL = fileURL
        showPDF = true
    }
}

struct PDFViewer: View {
    let url: URL
    
    var body: some View {
        PDFKitRepresentedView(url)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("PDF Viewer")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL
    
    init(_ url: URL) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        // Nothing to update
    }
}
