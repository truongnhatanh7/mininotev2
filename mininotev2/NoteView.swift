//
//  NoteView.swift
//  mininotev2
//
//  Created by Truong Nhat Anh on 02/06/2022.
//

import SwiftUI

struct NoteView: View {
    @State var title = ""
    @State var noteText = "lorem #bipsum#b siba li sasd djji ff -hard-"
    var body: some View {
         //TextEditor(text: $noteText)
        TextView(text: $noteText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        print("Done")
                    }
                }
            }
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String
    let textStorage = NSTextStorage()
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeUIView(context: Context) -> UITextView {
        let attrs = [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .body)]
        let attrString = NSAttributedString(string: text, attributes: attrs)
        textStorage.append(attrString)
        let layoutManager = NSLayoutManager()
        let container = NSTextContainer(size: CGSize())
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
        let textView = UITextView(frame: CGRect(), textContainer: container)
        return textView
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        context.coordinator.updateAttributedString()
        //uiView.attributedText = context.coordinator.updateAttributedString()
    }
    
    class Coordinator: NSObject {
        var parent: TextView
        var replacements: [String: [NSAttributedString.Key : Any]] = [:]
        init(_ textView: TextView) {
            self.parent = textView
            super.init()
            
            let strikeThroughAttributes = [NSAttributedString.Key.strikethroughStyle: 1]
            let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
            let descriptorWithTrait = fontDescriptor.withSymbolicTraits(.traitBold)
            let font = UIFont(descriptor: descriptorWithTrait!, size: 0)
            let boldAttributes = [NSAttributedString.Key.font: font]
            replacements = ["(-\\w+(\\s\\w+)*-)":strikeThroughAttributes,
                            "(#b\\w+(\\s\\w+)*#b)":boldAttributes
            ]
        }
        func updateAttributedString() {
            for (pattern, attributes) in replacements {
                do {
                    let regex = try NSRegularExpression(pattern: pattern)
                    let string = parent.text
                    let range = NSRange(string.startIndex..., in: string)
                    regex.enumerateMatches(in: string, range: range) {
                        match, flag, stop in
                        if let matchRange = match?.range(at: 1) {
                            parent.textStorage.addAttributes(attributes, range: matchRange)
                        }
                    }
    
                } catch {
                    print("Error occurred")
                }
            }
        }
        
    }
    typealias UIViewType = UITextView
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
