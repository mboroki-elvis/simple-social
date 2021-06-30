//
//  UserCell.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import UIKit

class UserCell: UITableViewCell {
    var dataSourceItem: DataUsers? {
        didSet {
            guard let source = dataSourceItem else {
                return
            }
            debugPrint(source.company)
            contactView.dataSourceItem = source
            addressView.dataSourceItem = source.address
            companyView.dataSourceItem = source.company
            if let location = source.address?.location {
                addressView.mapView.centerToLocation(location)
            }
        }
    }

    let contactView: DetailsView = {
        let view = DetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let addressView: AddressDetailsView = {
        let view = AddressDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let companyView: CompanyDetailsView = {
        let view = CompanyDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contactView)
        contentView.addSubview(addressView)
        contentView.addSubview(companyView)
        let contraints = [
            contactView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contactView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contactView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contactView.bottomAnchor.constraint(equalTo: addressView.topAnchor, constant: -Constants.defaultPadding),

            addressView.topAnchor.constraint(equalTo: contactView.bottomAnchor, constant: Constants.defaultPadding),
            addressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultPadding),
            addressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultPadding),
            addressView.bottomAnchor.constraint(equalTo: companyView.topAnchor, constant: -Constants.defaultPadding),

            companyView.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: Constants.defaultPadding),
            companyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultPadding),
            companyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultPadding),
            companyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(contraints)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
