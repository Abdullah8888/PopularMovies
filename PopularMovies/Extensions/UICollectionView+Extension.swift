//
//  UICollectionView+Extension.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func showEmptyViewWith(text: String, textColor: UIColor) {
        let emptyView: UIView = {
            let view = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
            view.backgroundColor = .darkGray
            view.cornerRadius = 13
            return view
        }()
        
        let messageLabel = Label(text: text, font: .helveticaNeueBold(size: 15), numberOfLines: 3, textColor: textColor, alignment: .center)
        
        emptyView.addSubview(messageLabel)
        
        messageLabel.placeAtCenterOf(centerY: emptyView.centerYAnchor, centerX: emptyView.centerXAnchor, verticalSpace: 0, horizontalSpace: 0)
        
        self.backgroundView = emptyView
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
