import XCTest

import SampleableTests

var tests = [XCTestCaseEntry]()
tests += SampleableTests.__allTests()

XCTMain(tests)
