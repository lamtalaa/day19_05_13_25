//
//  RBSNewsUITests.swift
//  RBSNewsUITests
//
//  RBS Tests Project on 12/10/20.
//

import XCTest

class RBSNewsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testLoginUI() {
        
        let app = XCUIApplication()
        app.launch()
        
        let titleLabel = app.navigationBars["Login screen"].staticTexts["Login screen"]
        
        XCTAssertTrue(titleLabel.exists)
        
        let userNameTF = app.textFields["Enter username"]
        
        XCTAssertTrue(userNameTF.exists)

       let passwordTf =  app.secureTextFields["Enter password"]
        
        XCTAssertTrue(passwordTf.exists)

       let button = app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(button.exists)
                
    }
   
    
    func testLoginButton_failure() {
        
        let app = XCUIApplication()
        app.launch()
        let userTextFiled = app.textFields["Enter username"]
        userTextFiled.tap()
        userTextFiled.typeText("rbs")
        
        let passwordTf = app.secureTextFields["Enter password"]
        
        passwordTf.tap()
        passwordTf.typeText("asdfa")
        
        app.staticTexts["Login"].tap()
        
        let elementsQuery = app.alerts["Alert!"].scrollViews.otherElements
        
        let alertMessage = elementsQuery.staticTexts["Alert!"]
        
        XCTAssertTrue(alertMessage.exists)
        
        let messageLbl = elementsQuery.staticTexts["Password is invalid"]
        XCTAssertTrue(messageLbl.exists)
        

        elementsQuery.buttons["Ok"].tap()
        
    }
    
    func testLoginButton_success() {
        let app = XCUIApplication()
        app.launch()
        let userTextFiled = app.textFields["Enter username"]
        userTextFiled.tap()
        userTextFiled.typeText("rbs")
        
        let passwordTf = app.secureTextFields["Enter password"]
        
        passwordTf.tap()
        passwordTf.typeText("1234")
        
        app.staticTexts["Login"].tap()
        
    
        let newsTitle = app.navigationBars["News screen"].staticTexts["News screen"]
        XCTAssertTrue(newsTitle.exists)

        
    }
   
}
