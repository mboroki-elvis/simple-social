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

    private var post: DataPosts?
    private var user: DataUsers?
    typealias DataSource = UITableViewDiffableDataSource<Section, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    private var fetchedResultsController: NSFetchedResultsController<DataComments>?
    private lazy var dataSource: DataSource = {
        DataSource(tableView: tableView, cellProvider: { [weak self] _, indexPath, _ -> UITableViewCell? in
            guard let self = self else { return nil }
            switch indexPath.section {
            case 0:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell
                cell?.dataSourceItem = self.post
                return cell
            case 1:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell
                cell?.dataSourceItem = self.user
                cell?.addressView.mapView.delegate = self
                return cell
            case 2:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell
                cell?.dataSourceItem = self.fetchedResultsController?.object(at: indexPath)
                return cell
            default:
                return nil
            }
        })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }

    required init(item: DataPosts) {
        super.init(style: .plain)
        post = item
        applySnapshot(animatingDifferences: true)
        handleSetupResultsController(item)
        debugPrint(item)
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
        debugPrint(snapshot.numberOfSections)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func handleSetupResultsController(_ item: DataPosts) {
        fetchedResultsController = DataComments.getController(postId: item.id)
        fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print(error)
        }
    }

    private func getUser(item: DataPosts) {
        user = DataUsers.getSingle(id: item.userId)
        if user == nil {
            Networking.shared.get(group: .users(.single, item.id.description)) { data, error in
                if let data = data {
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        DataUsers.saveData(items: [user])
                    } catch {
                        print(error)
                    }
                } else if let error = error {
                    print(error)
                }
            }
        }
    }

    private func getComments(item: DataPosts) {
        if let controller = fetchedResultsController {
            if controller.fetchedObjects?.count == .zero {
                getData(item)
                debugPrint("this is the item")
            } else {
                debugPrint("coredata: \(String(describing: controller.fetchedObjects?.count))")
            }
        }
    }

    private func getData(_ item: DataPosts) {
        Networking.shared.get(group: .comments(.single, item.id.description)) { data, error in
            if let data = data {
                do {
                    let comments = try JSONDecoder().decode(Comments.self, from: data)
                    DataComments.saveData(items: comments)
                } catch {
                    print(error)
                }
            } else if let error = error {
                print(error)
            }
        }
    }

    override func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = HeaderLabel()
        label.text = ["", "User Details", "Comments"][section]
        label.textColor = StyleHelper.itemTintColor
        label.font = StyleHelper.defaultBoldFont
        label.textAlignment = .left
        label.backgroundColor = StyleHelper.backgroundColor
        label.translatesAutoresizingMaskIntoConstraints = false
        let containerView = UIView()
        containerView.addSubview(label)
        containerView.backgroundColor = StyleHelper.backgroundColor
        label.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constants.doublePadding).isActive = true
        label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Constants.doublePadding).isActive = true
        label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.defaultPadding).isActive = true
        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.defaultPadding).isActive = true
        return containerView
    }
}

extension DetailsController: NSFetchedResultsControllerDelegate {
    func controller(_: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
//        let snapshot = snapshot as Snapshot
//        debugPrint(snapshot.numberOfSections)
//        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension DetailsController: MKMapViewDelegate, CLLocationManagerDelegate {}
