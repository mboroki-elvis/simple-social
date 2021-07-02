//
//  PostCell.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import UIKit

class PostCell: UITableViewCell {
    // MARK: Lifecycle

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        textLabel?.numberOfLines = .zero
        textLabel?.textColor = StyleHelper.itemTintColor
        textLabel?.font = UIFont.font(weight: .bold, ofSize: 18)
        detailTextLabel?.numberOfLines = .zero
        detailTextLabel?.textColor = .gray
        detailTextLabel?.font = UIFont.font(weight: .regular, ofSize: 14)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    var dataSourceItem: DataPosts? {
        didSet {
            guard let source = dataSourceItem else {
                return
            }
            textLabel?.text = source.title?.capitalized
            detailTextLabel?.text = source.body?.condensed
        }
    }
}
