//
//  DetailsView.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import UIKit

class DetailsView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameButton)
        addSubview(emailButton)
        addSubview(phoneButton)
        addSubview(websiteButton)
        let constraints = [
            nameButton.topAnchor.constraint(equalTo: topAnchor),
            nameButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.defaultPadding),
            nameButton.widthAnchor.constraint(equalTo: emailButton.widthAnchor),
            nameButton.trailingAnchor.constraint(equalTo: emailButton.leadingAnchor),
            nameButton.bottomAnchor.constraint(equalTo: phoneButton.topAnchor, constant: -Constants.defaultPadding),

            emailButton.topAnchor.constraint(equalTo: nameButton.topAnchor),
            emailButton.widthAnchor.constraint(equalTo: nameButton.widthAnchor),
            emailButton.leadingAnchor.constraint(equalTo: nameButton.trailingAnchor),
            emailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.defaultPadding),
            emailButton.bottomAnchor.constraint(equalTo: nameButton.bottomAnchor),

            phoneButton.topAnchor.constraint(equalTo: nameButton.bottomAnchor, constant: Constants.defaultPadding),
            phoneButton.leadingAnchor.constraint(equalTo: nameButton.leadingAnchor),
            phoneButton.widthAnchor.constraint(equalTo: websiteButton.widthAnchor),
            phoneButton.trailingAnchor.constraint(equalTo: websiteButton.leadingAnchor),
            phoneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.defaultPadding),

            websiteButton.topAnchor.constraint(equalTo: phoneButton.topAnchor),
            websiteButton.widthAnchor.constraint(equalTo: phoneButton.widthAnchor),
            websiteButton.leadingAnchor.constraint(equalTo: phoneButton.trailingAnchor),
            websiteButton.trailingAnchor.constraint(equalTo: emailButton.trailingAnchor),
            websiteButton.bottomAnchor.constraint(equalTo: phoneButton.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    weak var delegate: UserActionDelegate?
    lazy var nameButton: LabelWithImage = {
        let button = LabelWithImage()
        button.tag = UserAction.name.rawValue
        button.selectImage.image = #imageLiteral(resourceName: "icon-name").withRenderingMode(.alwaysTemplate)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doAction)))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var emailButton: LabelWithImage = {
        let button = LabelWithImage()
        button.tag = UserAction.email.rawValue
        button.selectImage.image = #imageLiteral(resourceName: "icon-email").withRenderingMode(.alwaysTemplate)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doAction)))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var phoneButton: LabelWithImage = {
        let button = LabelWithImage()
        button.tag = UserAction.phone.rawValue
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doAction)))
        button.selectImage.image = #imageLiteral(resourceName: "icon-phone").withRenderingMode(.alwaysTemplate)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var websiteButton: LabelWithImage = {
        let button = LabelWithImage()
        button.tag = UserAction.website.rawValue
        button.selectImage.image = #imageLiteral(resourceName: "icon-website").withRenderingMode(.alwaysTemplate)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doAction)))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var dataSourceItem: DataUsers? {
        didSet {
            guard let source = dataSourceItem else { return }
            nameButton.titleLabel.text = source.name
            emailButton.titleLabel.text = source.email
            phoneButton.titleLabel.text = source.phone
            websiteButton.titleLabel.text = source.website
        }
    }

    // MARK: Private

    @objc private func doAction(sender: UITapGestureRecognizer) {
        guard let view = sender.view, let action = UserAction(rawValue: view.tag) else {
            return
        }
        debugPrint(action)
        delegate?.didSelectItem(action: action)
    }
}
