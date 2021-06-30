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
    // MARK: Internal

    enum Section {
        case main
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, NSManagedObjectID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, NSManagedObjectID>

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
        tableView.accessibilityIdentifier = "HomeScreen"
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

    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        if searchText.isEmpty {
            fetchedResultsController = DataPosts.getController()
        } else {
            fetchedResultsController = DataPosts.search(term: searchText)
        }
        fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            Logger.shared.log(error)
        }
    }

    // MARK: Private

    private lazy var dataSource: DataSource = {
        DataSource(tableView: tableView, cellProvider: { [weak self] _, indexPath, _ -> UITableViewCell? in
            guard let self = self else { return nil }
            let cell = self.tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell
            cell?.dataSourceItem = self.fetchedResultsController?.object(at: indexPath)
            cell?.accessibilityIdentifier = "HomeScreen_\(indexPath.row)"
            return cell
        })
    }()

    private var fetchedResultsController: NSFetchedResultsController<DataPosts>?

    private func setupDataController() {
        fetchedResultsController = DataPosts.getController()
        fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            Logger.shared.log(error)
        }
    }

    private func getData() {
        Networking.shared.get(group: .posts(.all, "")) { data, error in
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode(Posts.self, from: data)
                    DataPosts.saveData(items: posts)
                } catch {
                    Logger.shared.log(error)
                }
            } else if let error = error {
                Logger.shared.log(error)
            }
        }
    }

    private func setupData() {
        if let controller = fetchedResultsController, controller.fetchedObjects?.count == .zero {
            getData()
        }
    }
}

extension HomeController: NSFetchedResultsControllerDelegate {
    func controller(_: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        let snapshot = snapshot as Snapshot
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
