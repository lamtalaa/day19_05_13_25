//
//  RBSNewsTests.swift
//  RBSNewsTests
//
//  RBS Tests Project on 12/10/20.
//

// @testable: will make all internal functions, classes , variables as public

import XCTest
@testable import RBSNews

class RBSNewsTests: XCTestCase {
    
    
    let loginViewController = LoginViewController()
    
    override func setUp() {
        
        
    }

    override func tearDown() {
        
    }

    func testDivide() {
        let actualOutput =  try! loginViewController.divide(a: 6, b: 3)
         let expectedOutput = 2
         
         XCTAssertEqual(expectedOutput, actualOutput)
    }
    
    func testDivide_byZero() {
        do {
            let actualOutput =  try loginViewController.divide(a: 6, b: 0)

        } catch {
            let expectedOutput = CustomError.divideByZero

            XCTAssertEqual(expectedOutput, error as! CustomError)

        }
        
    }
    
    func testGetName() {
        let index = 0
        
        let actualOutput = loginViewController.getName(for: index)
        let expectedOutput = "apple"
        XCTAssertEqual(expectedOutput, actualOutput)

    }
    
    func testGetName_outOfIndex() {
        let index = 4
        
        let actualOutput = loginViewController.getName(for: index)
        let expectedOutput = ""
        XCTAssertEqual(expectedOutput, actualOutput)

    }
    
    func testGetName_negativeIndex() {
        let index = -2
        
        let actualOutput = loginViewController.getName(for: index)
        let expectedOutput = ""
        XCTAssertEqual(expectedOutput, actualOutput)

    }
    
}



