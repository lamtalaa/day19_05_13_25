//
//  LoginViewControllerTests.swift
//  RBSNewsTests
//
//  Created by Mac on 12/05/25.
//

import XCTest
@testable import RBSNews


final class LoginViewControllerTests: XCTestCase {

    var loginVc: LoginViewController!
    override func setUp()  {
        loginVc = LoginViewController()
    }

    override func tearDown()  {
        loginVc = nil
    }
    
    func test_validate_nil_credentials()  {
    
       let output =  loginVc.validate(name: nil, pass: nil)
    
        let expectedOutput = "Please input credentials."
        
        XCTAssertEqual(output, expectedOutput)
        
    }
    
    func test_validate_empty_credentials()  {
    
       let output =  loginVc.validate(name: "", pass: "")
    
        let expectedOutput = "Please input credentials."
        
        XCTAssertEqual(output, expectedOutput)
        
    }
    
    func test_validate_incorrenctUserName()  {
    
       let output =  loginVc.validate(name: "adfasd", pass: "asd")
    
        let expectedOutput = "Username is invalid"
        
        XCTAssertEqual(output, expectedOutput)
        
    }
    
    func test_validate_currectUserName_IncorrectPassowrd()  {
    
       let output =  loginVc.validate(name: "rbs", pass: "adfa")
    
        let expectedOutput = "Password is invalid"
        
        XCTAssertEqual(output, expectedOutput)
        
    }
    
    func test_validate_correctCredentails()  {
    
       let output =  loginVc.validate(name: "rbs", pass: "1234")
    
        let expectedOutput = ""
        
        XCTAssertEqual(output, expectedOutput)
        
    }
                                      
                                    
                                      
}
