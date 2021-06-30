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
    enum Section {
        case description
        case user
        case comments
    }

    enum Wrapper: Hashable {
        case one(DataPosts)
        case two(DataUsers)
        case three([DataComments])
    }

    private var post: DataPosts?
    private var user: DataUsers?
    typealias DataSource = UITableViewDiffableDataSource<Section, Wrapper>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Wrapper>
    private lazy var dataSource: DataSource = {
        DataSource(tableView: tableView, cellProvider: { [weak self] _, indexPath, item -> UITableViewCell? in
            debugPrint("item: \(item)")
            guard let self = self else { return nil }
            debugPrint("item: \(item)")
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
            case let .three(comments):
                let cell = self.tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell
                cell?.dataSourceItem = comments[indexPath.item]
                return cell
            }
        })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
    }

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

    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.description])
        snapshot.appendSections([.user])
        snapshot.appendSections([.comments])
        snapshot.appendItems([Wrapper.one(post!)], toSection: .description)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

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
                    print(error)
                }
            }
        } else {
            updateUser()
        }
    }

    private func getComments(item: DataPosts) {
        if let comments = item.comments?.allObjects as? [DataComments], !comments.isEmpty {
            var snapshot = dataSource.snapshot()
            snapshot.appendItems([Wrapper.three(comments)], toSection: .comments)
            dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
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
                } catch {
                    Logger.shared.log(error)
                }
            } else if let error = error {
                print(error)
            }
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

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == .zero ? .leastNonzeroMagnitude : UITableView.automaticDimension
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
                let activityViewController = UIActivityViewController(activityItems: ["@\(name)"], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = view
                activityViewController.excludedActivityTypes = []
                present(activityViewController, animated: true, completion: nil)
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
extension DetailsController: MKMapViewDelegate, CLLocationManagerDelegate {}
