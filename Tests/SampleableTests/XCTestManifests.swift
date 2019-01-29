import XCTest

extension SampleableTests {
    static let __allTests = [
        ("test_SimpleComposition", test_SimpleComposition),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SampleableTests.__allTests),
    ]
}
#endif
