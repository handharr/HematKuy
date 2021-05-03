//
//  Extensions.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 02/05/21.
//

import UIKit


extension UILabel {
    func setTextInfoAmount (
        fullText : String,
        word1 : String,
        word2: String?,
        color1 : UIColor,
        color2: UIColor?
    ) {
        
        let strNumber: NSString = fullText as NSString
        let attribute = NSMutableAttributedString.init(string: fullText)
        
        let range1 = (strNumber).range(of: word1)
        attribute.addAttribute(.foregroundColor, value: color1, range: range1)
        attribute.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: range1)
        
        if let word2 = word2, let color2 = color2 {
            let range2 = (strNumber).range(of: word2)
            attribute.addAttribute(.foregroundColor, value: color2, range: range2)
            attribute.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: range2)
        }
        
        self.attributedText = attribute
    }
}
