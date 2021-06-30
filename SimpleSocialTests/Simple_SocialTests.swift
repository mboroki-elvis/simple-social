//
//  Simple_SocialTests.swift
//  Simple SocialTests
//
//  Created by Elvis Mwenda on 29/06/2021.
//

@testable import SimpleSocial
import XCTest

class SimpleSocialTests: XCTestCase {
    var networking: Networking?

    override func setUpWithError() throws {
        try super.setUpWithError()
        networking = Networking.shared
    }

    override func tearDownWithError() throws {
        networking = nil
        super.tearDown()
    }

    func testPostsAreSynchronized() { // This is just a simple test
        var postings: [Post] = []
        networking?.get(group: .posts(.all, "")) { data, error in
            if let data = data {
                do {
                    postings = try JSONDecoder().decode(Posts.self, from: data)
                    DataPosts.saveData(items: postings)
                } catch {
                    Logger.shared.log(error)
                }
            } else if let error = error {
                Logger.shared.log(error)
            }
        }
        let exp = expectation(description: "Test after 5 seconds")
        let stored = DataPosts.getData()
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(stored.count, postings.count, "These items are synchronized")
        } else {
            XCTFail("Delay interrupted")
        }
    }

    func testCorrectItemPassedToController() { // This is just a simple test
        let stored = DataPosts.getData()
        if let first = stored.first, let comments = first.comments?.allObjects as? [DataComments], let comment = comments.first {
            let controller = DetailsController(item: first)
            if let source = controller.tableView.dataSource as? UITableViewDiffableDataSource<DetailsController.Section, DetailsController.Wrapper> {
                let indexPath = source.indexPath(for: DetailsController.Wrapper.three(comment))
                XCTAssert(indexPath != nil, "Sections and items have been created")
            }
        } else {
            XCTFail("Core Data items not found")
        }
    }

    func testPerformanceExample() throws {
        measure(
            metrics: [
                XCTClockMetric(),
                XCTCPUMetric(),
                XCTStorageMetric(),
                XCTMemoryMetric()
            ]
        ) {
            _ = DataPosts.getData()
        }
    }
}
