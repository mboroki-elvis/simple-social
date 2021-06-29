//
//  ViewController.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import CoreData
import Foundation
import UIKit

class HomeController: UITableViewController, UISearchResultsUpdating {
    enum Section {
        case main
    }

    private lazy var dataSource: DataSource = {
        DataSource(tableView: tableView, cellProvider: { [weak self] _, indexPath, _ -> UITableViewCell? in
            guard let self = self else { return nil }
            let cell = self.tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell
            cell?.dataSourceItem = self.fetchedResultsController?.object(at: indexPath)
            return cell
        })
    }()

    typealias DataSource = UITableViewDiffableDataSource<Section, NSManagedObjectID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, NSManagedObjectID>
    private var fetchedResultsController: NSFetchedResultsController<DataPosts>?
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.automaticallyShowsSearchResultsController = true
        controller.hidesNavigationBarDuringPresentation = false
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search...."
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts Feed"
        tableView.dataSource = dataSource
        applySnapshot(animatingDifferences: true)
        setupDataController()
        setupData()
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = fetchedResultsController?.object(at: indexPath) else {
            return
        }
        let controller = DetailsController(item: post)
        navigationController?.pushViewController(controller, animated: true)
    }

    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func updateSearchResults(for _: UISearchController) {
        applySnapshot()
    }

    private func setupDataController() {
        fetchedResultsController = DataPosts.getController()
        fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print(error)
        }
    }

    fileprivate func getData() {
        Networking.shared.get(group: .posts(.all, "")) { data, error in
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode(Posts.self, from: data)
                    DataPosts.saveData(items: posts)
                    debugPrint(posts.count)
                } catch {
                    print(error)
                }
            } else if let error = error {
                print(error)
            }
        }
    }

    private func setupData() {
        if let controller = fetchedResultsController {
            if controller.fetchedObjects?.count == .zero {
                getData()
                debugPrint("this is the item")
            } else {
                debugPrint("coredata: \(String(describing: controller.fetchedObjects?.count))")
            }
        }
    }
}

extension HomeController: NSFetchedResultsControllerDelegate {
    func controller(_: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        guard let dataSource = tableView?.dataSource as? DataSource else {
            fatalError("The data source has not implemented snapshot support while it should")
        }
        let snapshot = snapshot as Snapshot
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension HomeController: UITableViewDataSourcePrefetching {
    func tableView(_: UITableView, prefetchRowsAt _: [IndexPath]) {}
}
