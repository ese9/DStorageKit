//
//  DStorageKitTests.swift
//  DStorageKitTests
//
//  Created by Roman Novikov on 7/17/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import XCTest
import DStorageKit

class DStorageKitTests: XCTestCase {
    
    private let sectionKey = "sectionKey"
    private var dataSource: TableDataSource!

    override func setUp() {
        dataSource = TableDataSource()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testHandlingSection() {
        let newSection = TableSection(priority: 0, minRowsCount: 1, maxRowsCount: 2)
        dataSource.addNewSection(with: sectionKey, newSection)
        
        let addedSection: TableSection<UITableViewCell>? = dataSource[sectionKey]
        XCTAssert(addedSection != nil, "Cant get section by sectionKey from dataSource")
        XCTAssertEqual(dataSource.sectionsCount, 1, "Section wasn't added to dataSource array")
        
        dataSource.removeSection(with: sectionKey)
        let deletedSection: TableSection<UITableViewCell>? = dataSource[sectionKey]
        XCTAssert(deletedSection == nil, "Section wasn't removed from dataSource")
        XCTAssertEqual(dataSource.sectionsCount, 0, "Section wasn't removed from dataSource array")
    }
    
    func testGettingSectionIndex() {
        
        let firstSection = TableSection(priority: 1, minRowsCount: 1, maxRowsCount: 2)
        dataSource.addNewSection(with: sectionKey+"0", firstSection)
        
        let thirdSection = TableSection(priority: 3, minRowsCount: 1, maxRowsCount: 2)
        dataSource.addNewSection(with: sectionKey+"2", thirdSection)

        let secondSection = TableSection(priority: 2, minRowsCount: 1, maxRowsCount: 2)
        dataSource.addNewSection(with: sectionKey+"1", secondSection)

        let sectionIndex = dataSource.getSectionIndex(key: sectionKey+"1")
        XCTAssertEqual(sectionIndex, 1, "Section index is wrong")
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
