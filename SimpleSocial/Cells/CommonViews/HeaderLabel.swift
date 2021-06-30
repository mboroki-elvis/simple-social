//
//  HeaderLabel.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import UIKit

class HeaderLabel: UILabel {
    override var intrinsicContentSize: CGSize {
        let orginialContentSize = super.intrinsicContentSize
        let height = orginialContentSize.height + 10
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        adjustsFontSizeToFitWidth = true
        return CGSize(width: orginialContentSize.width + 10, height: height)
    }
}

class ButtonWithImage: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    override var intrinsicContentSize: CGSize {
        let orginialContentSize = super.intrinsicContentSize
        let height = orginialContentSize.height + 10
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: orginialContentSize.width + 10, height: height)
    }
}
