//
//  swift_auth_fire_clerk_walletconnect_supUITestsLaunchTests.swift
//  swift-auth-fire-clerk-walletconnect-supUITests
//
//  Created by Devor Vlad on 28/8/2024.
//

import XCTest

final class swift_auth_fire_clerk_walletconnect_supUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
