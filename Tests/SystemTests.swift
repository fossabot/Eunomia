//
//  SystemTests.swift
//  Eunomia
//
//  Created by Ian Grossberg on 7/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation
import XCTest

import Eunomia

class SystemTests: XCTestCase {
    
    func testGetAppDocumentPaths() {
        let paths = getAppDocumentPaths()
        
        XCTAssertNotNil(paths, "Result should not be nil")
        XCTAssertGreaterThan(paths!.count, 0, "Result should include at least one path")
    }
    
    func testGetAppDocumentPath() {
        let path = getAppDocumentPath()
        
        XCTAssertNotNil(path, "Result should not be nil")
    }
    
    func testGetAppLibraryPaths() {
        let paths = getAppLibraryPaths()
        
        XCTAssertNotNil(paths, "Result should not be nil")
        XCTAssertGreaterThan(paths!.count, 0, "Result should include at least one path")

    }
    
    func testGetAppLibraryPath() {
        let path = getAppLibraryPath()
        
        XCTAssertNotNil(path, "Result should not be nil")
    }
}
