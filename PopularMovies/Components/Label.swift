//
//  Label.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
import UIKit

class Label: UILabel {

    private var insets = UIEdgeInsets(allEdges: 0)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width + insets.left + insets.right, height: originalSize.height + insets.top + insets.bottom)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .helveticaNeueRegular(size: 13)
    }
    
    init(text: String, font: UIFont, numberOfLines: Int = 0, textColor: UIColor = .black, alignment: NSTextAlignment = .left, underlined: Bool = false, padding: UIEdgeInsets = .init(allEdges: 0), letterSpacing: CGFloat = 0, lineBreakMode: NSLineBreakMode = .byWordWrapping) {
        super.init(frame: .zero)
        self.font = font
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.insets = padding
        self.lineBreakMode = lineBreakMode
        //self.adjustsFontSizeToFitWidth = true
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
