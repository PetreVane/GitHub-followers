import XCTest
@testable import CustomUIElements

final class CustomUIElementsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CustomUIElements().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
