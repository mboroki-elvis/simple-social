//
//  PostCell.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import UIKit

class PostCell: UITableViewCell {
    var dataSourceItem: DataPosts? {
        didSet {
            guard let source = dataSourceItem else {
                return
            }
            textLabel?.text = source.title
            detailTextLabel?.text = source.body
        }
    }

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        textLabel?.numberOfLines = .zero
        textLabel?.textColor = StyleHelper.itemTintColor
        textLabel?.font = StyleHelper.defaultBoldFont
        detailTextLabel?.numberOfLines = .zero
        detailTextLabel?.textColor = .gray
        detailTextLabel?.font = StyleHelper.defaultFont
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
