//
//  UserCell.swift
//  SimpleSocial
//
//  Created by Elvis Mwenda on 30/06/2021.
//

import MapKit
import UIKit

enum UserAction: Int {
    case name = 0, email, phone, website
}

protocol UserActionDelegate: AnyObject {
    func didSelectItem(action: UserAction)
}

class UserCell: UITableViewCell {
    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(contactView)
        contentView.addSubview(addressView)
        contentView.addSubview(companyView)
        let contraints = [
            contactView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.defaultPadding),
            contactView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contactView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contactView.bottomAnchor.constraint(equalTo: addressView.topAnchor, constant: -Constants.defaultPadding),

            addressView.topAnchor.constraint(equalTo: contactView.bottomAnchor, constant: Constants.defaultPadding),
            addressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.doublePadding),
            addressView.heightAnchor.constraint(equalToConstant: 200),
            addressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.doublePadding),
            addressView.bottomAnchor.constraint(equalTo: companyView.topAnchor, constant: -Constants.defaultPadding),

            companyView.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: Constants.defaultPadding),
            companyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.doublePadding),
            companyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.doublePadding),
            companyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(contraints)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

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

    var dataSourceItem: DataUsers? {
        didSet {
            guard let source = dataSourceItem else {
                return
            }
            contactView.dataSourceItem = source
            companyView.dataSourceItem = source.company
            if let location = source.address?.location {
                addressView.mapView.centerToLocation(location)
                let annotation = MKPointAnnotation()
                annotation.title = source.address?.city
                annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                addressView.mapView.addAnnotation(annotation)
            }
        }
    }
}
