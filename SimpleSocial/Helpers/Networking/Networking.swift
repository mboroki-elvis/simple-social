//
//  ApiHelper.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import Foundation
import Alamofire

class Networking: NSObject {
    static var shared = Networking()
    func get(group: ApiGroup, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: group.path) else { return }
        AF.request(url, method: .get, parameters: [:], headers: Constants.headers).responseJSON { data in
            completion(data.data, data.error)
        }
    }
}
