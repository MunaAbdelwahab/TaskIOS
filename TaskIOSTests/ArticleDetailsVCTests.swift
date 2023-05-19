//
//  ArticleDetailsVCTests.swift
//  TaskIOSTests
//
//  Created by Muna Abdelwahab on 19/05/2023.
//

import XCTest
@testable import TaskIOS

final class ArticleDetailsVCTests: XCTestCase {
    
    var controller: ArticleDetailsVC?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(identifier: "ArticleDetailsVC")
        controller?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        
        controller = nil
    }

    func testOutletsShouldBeConnected() {
        XCTAssertNotNil(controller?.webView)
        XCTAssertNotNil(controller?.rateNum)
        XCTAssertNotNil(controller?.rate)
    }
    
    func testOutletsTFProperties() {
        XCTAssertEqual(controller?.rateNum.placeholder, "Rate Article 1 ... 5")
        XCTAssertEqual(controller?.rateNum.keyboardType, .numberPad)
    }

    func testSaveButton() {
        tap(controller?.saveBt)
    }
    
    func tap(_ button: UIButton?) {
        button?.sendActions(for: .touchUpInside)
    }
}
