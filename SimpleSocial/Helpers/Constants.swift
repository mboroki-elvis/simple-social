//
//  Constants.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import Alamofire
import UIKit

enum Constants {
    static var defaultPadding: CGFloat = 8
    static var doublePadding: CGFloat = 16
    static var headers: HTTPHeaders = .init(["Accept": "application/json",
                                             "Content-type": "application/json; charset=UTF-8"])
}
