//
//  Logger.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import UIKit

class Logger: NSObject {
    static let shared = Logger()

    // We should add sentry, datadog, crashlytics etc here
    func log(_ error: Error) {
        print("common log: \(error)")
    }
}
