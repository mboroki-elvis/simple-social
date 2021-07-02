//
//  CommentCell.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import UIKit

class CommentCell: UITableViewCell {
    // MARK: Lifecycle

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        textLabel?.numberOfLines = .zero
        textLabel?.textColor = StyleHelper.itemTintColor
        textLabel?.font = StyleHelper.defaultBoldFont
        detailTextLabel?.numberOfLines = .zero
        detailTextLabel?.textColor = .gray
        detailTextLabel?.font = UIFont.font(weight: .regular, ofSize: 12)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    var dataSourceItem: DataComments? {
        didSet {
            guard let source = dataSourceItem else {
                return
            }
            if let userName = source.email?.components(separatedBy: "@").first {
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue, NSAttributedString.Key.font: UIFont.font(weight: .bold, ofSize: 18)]
                let att = NSMutableAttributedString(string: "@\(userName) \n", attributes: attributes)
                let titleAtt = [NSAttributedString.Key.foregroundColor: StyleHelper.itemTintColor, NSAttributedString.Key.font: StyleHelper.defaultBoldFont]
                let title = NSAttributedString(string: source.name ?? "", attributes: titleAtt)
                att.append(title)
                textLabel?.attributedText = att
            }
            detailTextLabel?.text = source.body?.condensed
        }
    }
}
