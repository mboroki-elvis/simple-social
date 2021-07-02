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
        logToSentry(error)
        logToDataDog(error)
        logToCrashLytics(error)
    }
    
    func logToSentry(_ error: Error) {
        //// do sentry stuff
    }
    
    func logToDataDog(_ error: Error) {
        //// do logToDataDog stuff
    }
    
    func logToCrashLytics(_ error: Error) {
        //// do crashlytics stuff
    }
}
