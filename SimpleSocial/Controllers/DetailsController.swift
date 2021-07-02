//
//  DetailsController.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import CoreData
import CoreLocation
import MapKit
import UIKit

class DetailsController: UITableViewController {
    // MARK: Lifecycle

    required init(item: DataPosts) {
        super.init(style: .grouped)
        post = item
        applySnapshot(animatingDifferences: true)
        getUser(item: item)
        getComments(item: item)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    enum Section {
        case description
        case user
        case comments
    }

    enum Wrapper: Hashable {
        case one(DataPosts)
        case two(DataUsers)
        case three(DataComments)
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, Wrapper>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Wrapper>

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
    }

    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.description])
        snapshot.appendSections([.user])
        snapshot.appendSections([.comments])
        if let post = post {
            snapshot.appendItems([Wrapper.one(post)], toSection: .description)
            dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
        }
    }

    override func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == .zero {
            return nil
        }
        let label = HeaderLabel()
        label.text = ["", "Contact Details", "Comments"][section]
        label.textColor = StyleHelper.itemTintColor
        label.font = StyleHelper.defaultBoldFont
        label.textAlignment = .left
        label.backgroundColor = .systemGroupedBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        let containerView = UIView()
        containerView.addSubview(label)
        containerView.backgroundColor = .systemGroupedBackground
        label.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constants.doublePadding).isActive = true
        label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Constants.doublePadding).isActive = true
        label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.defaultPadding).isActive = true
        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.defaultPadding).isActive = true
        return containerView
    }

    override func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == .zero ? .leastNonzeroMagnitude : UITableView.automaticDimension
    }

    // MARK: Private

    private var post: DataPosts?
    private var user: DataUsers?
    private lazy var dataSource: DataSource = {
        DataSource(tableView: tableView, cellProvider: { [weak self] _, indexPath, item -> UITableViewCell? in
            guard let self = self else { return nil }
            switch item {
            case let .one(post):
                let cell = self.tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell
                cell?.dataSourceItem = post
                return cell
            case let .two(user):
                let cell = self.tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell
                cell?.dataSourceItem = user
                cell?.contactView.delegate = self
                cell?.addressView.mapView.delegate = self
                return cell
            case let .three(comment):
                let cell = self.tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell
                cell?.dataSourceItem = comment
                return cell
            }
        })
    }()

    private func updateUser() {
        if let user = user {
            var snapshot = dataSource.snapshot()
            snapshot.appendItems([Wrapper.two(user)], toSection: .user)
            dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }

    private func getUser(item: DataPosts) {
        user = DataUsers.getSingle(id: item.userId)
        if user == nil {
            Networking.shared.get(group: .users(.single, item.userId.description)) { data, error in
                if let data = data {
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        DataUsers.saveData(items: [user])
                        self.user = DataUsers.getSingle(id: item.userId)
                        self.updateUser()
                    } catch {
                        Logger.shared.log(error)
                    }
                } else if let error = error {
                    Logger.shared.log(error)
                }
            }
        } else {
            updateUser()
        }
    }

    private func getComments(item: DataPosts) {
        if let comments = item.comments?.allObjects as? [DataComments], !comments.isEmpty {
            var snapshot = dataSource.snapshot()
            comments.forEach { comment in
                snapshot.appendItems([Wrapper.three(comment)], toSection: .comments)
                self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
            }
        } else {
            getData(item)
        }
    }

    private func getData(_ item: DataPosts) {
        Networking.shared.get(group: .comments(.single, item.id.description)) { data, error in
            if let data = data {
                do {
                    let comments = try JSONDecoder().decode(Comments.self, from: data)
                    DataComments.saveData(items: comments)
                    if let dataComments = DataComments.getComments(postId: item.id) {
                        var snapshot = self.dataSource.snapshot()
                        dataComments.forEach { comment in
                            snapshot.appendItems([Wrapper.three(comment)], toSection: .comments)
                            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
                        }
                    }
                } catch {
                    Logger.shared.log(error)
                }
            } else if let error = error {
                Logger.shared.log(error)
            }
        }
    }
}

extension DetailsController: UserActionDelegate {
    func didSelectItem(action: UserAction) {
        guard let user = user else {
            return
        }
        switch action {
        case .name:
            if let name = user.name {
                let controller = UIActivityViewController(activityItems: ["@\(name)"], applicationActivities: nil)
                controller.popoverPresentationController?.sourceView = view
                controller.excludedActivityTypes = []
                present(controller, animated: true, completion: nil)
            }
        case .email:
            if let email = user.email, let url = URL(string: "mailto://\(email)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case .phone:
            if let phone = user.phone, let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case .website:
            if let website = user.website, let url = URL(string: "https://\(website)") {
                UIApplication.shared.open(url)
            }
        }
    }
}

extension DetailsController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        let anView = mapView.dequeueReusableAnnotationView(withIdentifier: MKAnnotationView.identifier, for: annotation)
        anView.annotation = annotation
        anView.canShowCallout = true
        anView.displayPriority = .required
        debugPrint(anView)
        return anView
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setCenter(userLocation.coordinate, animated: true)
    }
}
