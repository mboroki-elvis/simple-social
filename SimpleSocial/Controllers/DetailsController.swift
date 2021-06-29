//
//  DetailsController.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import UIKit

class DetailsController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    required init(item: DataPosts) {
        super.init(style: .plain)
        debugPrint(item)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func getUser() {
    }
}
