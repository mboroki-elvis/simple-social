//
//  LabelWithImage.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import UIKit

class LabelWithImage: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let selectImage: RoundImage = {
        let image = RoundImage()
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = StyleHelper.itemTintColor
        label.isUserInteractionEnabled = true
        label.font = UIFont.font(weight: .regular, ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Private

    private func setupViews() {
        backgroundColor = StyleHelper.backgroundColor
        isUserInteractionEnabled = true
        let containerView = UIView()
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 5
        containerView.layer.borderColor = StyleHelper.itemTintColor.cgColor
        containerView.backgroundColor = StyleHelper.backgroundColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(selectImage)
        containerView.addSubview(titleLabel)
        addSubview(containerView)
        let contraints = [
            containerView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.doublePadding),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.doublePadding),
            containerView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            selectImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.defaultPadding),
            selectImage.heightAnchor.constraint(equalToConstant: min(UIScreen.main.bounds.height / 8, 30)),
            selectImage.widthAnchor.constraint(equalToConstant: min(UIScreen.main.bounds.height / 8, 30)),
            selectImage.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -Constants.defaultPadding),
            selectImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.doublePadding),
            titleLabel.leadingAnchor.constraint(equalTo: selectImage.trailingAnchor, constant: Constants.defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.defaultPadding),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.doublePadding)
        ]
        NSLayoutConstraint.activate(contraints)
    }
}
