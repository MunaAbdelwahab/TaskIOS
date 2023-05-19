//
//  HomeVCTests.swift
//  TaskIOSTests
//
//  Created by Muna Abdelwahab on 19/05/2023.
//

import XCTest
@testable import TaskIOS

final class HomeVCTests: XCTestCase {

    var controller: HomeVC?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(identifier: "HomeVC")
        controller?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        
        controller = nil
    }

    func testOutletsShouldBeConnected() {
        XCTAssertNotNil(controller?.scrollView)
        XCTAssertNotNil(controller?.articlesTV)
        XCTAssertNotNil(controller?.articlesTVHeight)
    }
    
    func testTableViewDelegets() {
        XCTAssertNotNil(controller?.articlesTV.delegate)
        XCTAssertNotNil(controller?.articlesTV.dataSource)
    }
    
    func testGetArticles() {
        controller?.viewModel.getArticles()
    }

}
