////
////  StyleHelper.swift
////  wizard
////
////  Created by elvis on 14/02/2021.
////  Copyright © 2021 WUNI. All rights reserved.
////
//
//import UIKit
//
//public enum StyleHelper {
//    public enum Colors {
//        public static let label: UIColor = {
//            if #available(iOS 13.0, *) {
//                return UIColor.label
//            } else {
//                return .darkBlueColor
//            }
//        }()
//    }
//
//    static var itemTintColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.white
//                } else {
//                    return UIColor.black
//                }
//            }
//        } else {
//            return Colors.label
//        }
//    }()
//
//    static var backgroundColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return .black
//                } else {
//                    return .litePalest
//                }
//            }
//        } else {
//            return .litePalest
//        }
//    }()
//
//    static var cellColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.black
//                } else {
//                    return UIColor.white
//                }
//            }
//        } else {
//            return .white
//        }
//    }()
//
//    static var blackWhite: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.black
//                } else {
//                    return UIColor.white
//                }
//            }
//        } else {
//            return .white
//        }
//    }()
//
//    static var whiteBlack: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.white
//                } else {
//                    return UIColor.black
//                }
//            }
//        } else {
//            return .black
//        }
//    }()
//
//    static var labelColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.white
//                } else {
//                    return UIColor.darkBlueColor
//                }
//            }
//        } else {
//            return .darkBlueColor
//        }
//    }()
//
//    static var imageColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.white
//                } else {
//                    return UIColor.darkBlueColor
//                }
//            }
//        } else {
//            return .darkBlueColor
//        }
//    }()
//
//    static var navigationBarColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.black
//                } else {
//                    return UIColor.white
//                }
//            }
//        } else {
//            return .white
//        }
//    }()
//
//    static var buttonTintColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.white
//                } else {
//                    return UIColor.black
//                }
//            }
//        } else {
//            return .white
//        }
//    }()
//
//    static var homeSelectedColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.black
//                } else {
//                    return UIColor.white
//                }
//            }
//        } else {
//            return .white
//        }
//    }()
//
//    static var homeUnselectedSelectedColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.black
//                } else {
//                    return UIColor.litePalest
//                }
//            }
//        } else {
//            return .litePalest
//        }
//    }()
//
//    static var selectedOutlineColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.appColor
//                } else {
//                    return UIColor.white
//                }
//            }
//        } else {
//            return .white
//        }
//    }()
//
//    static var selectedTintColor: UIColor = {
//        if #available(iOS 13, *) {
//            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
//                if UITraitCollection.userInterfaceStyle == .dark {
//                    return UIColor.appColor
//                } else {
//                    return labelColor
//                }
//            }
//        } else {
//            return .litePalest
//        }
//    }()
//
//    static var actionColor: UIColor = {
//        return .litePalest
//    }()
//
//    static func setStyle() {
//        UITabBar.appearance().tintColor = .wuni
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.liteLarge]
//        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "icon-back")
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon-back")
//        UINavigationBar.appearance().barTintColor = navigationBarColor
//        UITableView.appearance().backgroundColor = navigationBarColor
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: labelColor], for: .normal)
//        UITableView.appearance().backgroundColor = backgroundColor
//        UICollectionView.appearance().backgroundColor = backgroundColor
//    }
//}
