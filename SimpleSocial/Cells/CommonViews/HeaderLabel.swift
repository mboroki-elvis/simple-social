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
