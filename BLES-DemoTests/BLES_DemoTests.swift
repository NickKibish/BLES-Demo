//
//  BLES_DemoTests.swift
//  BLES-DemoTests
//
//  Created by Nick Kibysh on 20/09/2023.
//

import XCTest
@testable import BLES_Demo

final class BLES_DemoTests: XCTestCase {

    func testExample() throws {
        let arr = [1,2,3,4]
        let groupedArr = arr.group2()
        
        XCTAssertEqual(arr[0], groupedArr[0].0)
        XCTAssertEqual(arr[1], groupedArr[0].1)
        XCTAssertEqual(arr[2], groupedArr[1].0)
        XCTAssertEqual(arr[3], groupedArr[1].1)
        
        let arr2 = [1,2,3,4,5]
        let groupedArr2 = arr2.group2()
        
        XCTAssertEqual(arr2[0], groupedArr2[0].0)
        XCTAssertEqual(arr2[1], groupedArr2[0].1)
        XCTAssertEqual(arr2[2], groupedArr2[1].0)
        XCTAssertEqual(arr2[3], groupedArr2[1].1)
        XCTAssertEqual(arr2[4], groupedArr2[2].0)
        XCTAssertNil(groupedArr2[2].1)
    }
}
