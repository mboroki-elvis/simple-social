//
//  StyleHelper.swift
//  wizard
//
//  Created by elvis on 14/02/2021.
//  Copyright © 2021 WUNI. All rights reserved.
//

import UIKit

public enum StyleHelper {
    static var itemTintColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor.white
                } else {
                    return UIColor.black
                }
            }
        } else {
            return UIColor.label
        }
    }()

    static var backgroundColor: UIColor = {
        UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .black
            } else {
                return .white
            }
        }
    }()

    static var defaultFont = UIFont(name: "ProximaNova-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
    static var defaultBoldFont = UIFont(name: "ProximaNova-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16)

    static func setStyle() {
        UITabBar.appearance().tintColor = itemTintColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.font(weight: .bold, ofSize: 20)]
        UINavigationBar.appearance().barTintColor = backgroundColor
        UINavigationBar.appearance().tintColor = itemTintColor
        UITableView.appearance().backgroundColor = backgroundColor
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: itemTintColor, NSAttributedString.Key.font: defaultBoldFont], for: .normal)
        UITableView.appearance().backgroundColor = backgroundColor
        UICollectionView.appearance().backgroundColor = backgroundColor
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}
