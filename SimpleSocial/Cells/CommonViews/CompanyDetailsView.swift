//
//  CompanyDetailsView.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import UIKit

class CompanyDetailsView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(companyLabel)
        addSubview(companyNameLabel)
        addSubview(tagLabel)
        addSubview(tagNameLabel)
        addSubview(businessLabel)
        addSubview(businessNameLabel)
        let width = UIScreen.main.bounds.width / 5
        let constraints = [
            companyLabel.topAnchor.constraint(equalTo: topAnchor),
            companyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            companyLabel.widthAnchor.constraint(equalToConstant: width),
            companyLabel.trailingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor),
            companyLabel.bottomAnchor.constraint(equalTo: tagLabel.topAnchor, constant: -Constants.defaultPadding),
            companyNameLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: companyLabel.trailingAnchor),
            companyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyNameLabel.bottomAnchor.constraint(equalTo: companyLabel.bottomAnchor),

            tagLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: Constants.defaultPadding),
            tagLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagLabel.widthAnchor.constraint(equalToConstant: width),
            tagLabel.trailingAnchor.constraint(equalTo: tagNameLabel.leadingAnchor),
            tagLabel.bottomAnchor.constraint(equalTo: businessLabel.topAnchor, constant: -Constants.defaultPadding),
            tagNameLabel.topAnchor.constraint(equalTo: tagLabel.topAnchor),
            tagNameLabel.leadingAnchor.constraint(equalTo: tagLabel.trailingAnchor),
            tagNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagNameLabel.bottomAnchor.constraint(equalTo: tagLabel.bottomAnchor),

            businessLabel.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: Constants.defaultPadding),
            businessLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            businessLabel.widthAnchor.constraint(equalToConstant: width),
            businessLabel.trailingAnchor.constraint(equalTo: businessNameLabel.leadingAnchor),
            businessLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.defaultPadding),
            businessNameLabel.topAnchor.constraint(equalTo: businessLabel.topAnchor),
            businessNameLabel.leadingAnchor.constraint(equalTo: businessLabel.trailingAnchor),
            businessNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            businessNameLabel.bottomAnchor.constraint(equalTo: businessLabel.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Company"
        label.font = StyleHelper.defaultBoldFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = StyleHelper.defaultFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let tagLabel: UILabel = {
        let label = UILabel()
        label.text = "Tag"
        label.font = StyleHelper.defaultBoldFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let tagNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = StyleHelper.defaultFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let businessLabel: UILabel = {
        let label = UILabel()
        label.text = "Business"
        label.font = StyleHelper.defaultBoldFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let businessNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = StyleHelper.defaultFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var dataSourceItem: DataCompany? {
        didSet {
            guard let source = dataSourceItem else { return }
            companyNameLabel.text = source.name
            tagNameLabel.text = source.catchPhrase
            businessNameLabel.text = source.bs
        }
    }
}
