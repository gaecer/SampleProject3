//
//  RoundedButton.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 15/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet { updateButton() }
    }
    
    @IBInspectable var disabledBackgroundColor: UIColor? = nil {
        didSet { updateButton() }
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
        updateButton()
    }
    
    private func updateButton() {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        if let disabledBackgroundColor = disabledBackgroundColor {
            setBackgroundImage(createImage(color: disabledBackgroundColor), for: .disabled)
        } else {
            setBackgroundImage(nil, for: .disabled)
        }
    }
    
    private func createImage(color: UIColor) -> UIImage {
        let size = CGSize(width: 1, height: 1)
        let renderer = UIGraphicsImageRenderer(size: size)
        let image =  renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)
            color.setFill()
            context.fill(rect)
        }
        
        return image
    }
    
}
