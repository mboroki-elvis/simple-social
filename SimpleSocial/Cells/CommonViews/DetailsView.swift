//
//  DetailsView.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import UIKit

class DetailsView: UIView {
    var dataSourceItem: DataUsers? {
        didSet {
            guard let source = dataSourceItem else { return }
            nameButton.setTitle(source.name, for: .normal)
            emailButton.setTitle(source.email, for: .normal)
            phoneButton.setTitle(source.phone, for: .normal)
            websiteButton.setTitle(source.website, for: .normal)
        }
    }

    let nameButton: ButtonWithImage = {
        let button = ButtonWithImage()
        button.setImage(#imageLiteral(resourceName: "icon-name").withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitleColor(StyleHelper.itemTintColor, for: .normal)
        button.titleLabel?.font = StyleHelper.defaultFont
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let emailButton: ButtonWithImage = {
        let button = ButtonWithImage()
        button.setImage(#imageLiteral(resourceName: "icon-email").withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitleColor(StyleHelper.itemTintColor, for: .normal)
        button.titleLabel?.font = StyleHelper.defaultFont
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let phoneButton: ButtonWithImage = {
        let button = ButtonWithImage()
        button.setImage(#imageLiteral(resourceName: "icon-phone").withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitleColor(StyleHelper.itemTintColor, for: .normal)
        button.titleLabel?.font = StyleHelper.defaultFont
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let websiteButton: ButtonWithImage = {
        let button = ButtonWithImage()
        button.setImage(#imageLiteral(resourceName: "icon-website").withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitleColor(StyleHelper.itemTintColor, for: .normal)
        button.titleLabel?.font = StyleHelper.defaultFont
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameButton)
        addSubview(emailButton)
        addSubview(phoneButton)
        addSubview(websiteButton)
        let constraints = [
            nameButton.topAnchor.constraint(equalTo: topAnchor),
            nameButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameButton.widthAnchor.constraint(equalTo: emailButton.widthAnchor),
            nameButton.trailingAnchor.constraint(equalTo: emailButton.leadingAnchor),
            nameButton.bottomAnchor.constraint(equalTo: phoneButton.topAnchor, constant: -Constants.defaultPadding),

            emailButton.topAnchor.constraint(equalTo: nameButton.topAnchor),
            emailButton.widthAnchor.constraint(equalTo: nameButton.widthAnchor),
            emailButton.leadingAnchor.constraint(equalTo: nameButton.trailingAnchor),
            emailButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            emailButton.bottomAnchor.constraint(equalTo: nameButton.bottomAnchor),

            phoneButton.topAnchor.constraint(equalTo: nameButton.bottomAnchor, constant: Constants.defaultPadding),
            phoneButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneButton.widthAnchor.constraint(equalTo: websiteButton.widthAnchor),
            phoneButton.trailingAnchor.constraint(equalTo: websiteButton.leadingAnchor),
            phoneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.defaultPadding),

            websiteButton.topAnchor.constraint(equalTo: phoneButton.topAnchor),
            websiteButton.widthAnchor.constraint(equalTo: phoneButton.widthAnchor),
            websiteButton.leadingAnchor.constraint(equalTo: phoneButton.trailingAnchor),
            websiteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            websiteButton.bottomAnchor.constraint(equalTo: phoneButton.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
