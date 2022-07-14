//
//  RoundedImageView.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 16/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 10.0 {
           didSet { updateImageView() }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
           didSet { updateImageView() }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
           didSet { updateImageView() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
    }
    
    private func commonInit() {
        updateImageView()
    }
    
    private func updateImageView() {
        clipsToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
    }
    
}
