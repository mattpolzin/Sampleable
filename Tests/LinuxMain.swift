import XCTest

import SampleableTests

var tests = [XCTestCaseEntry]()
tests += SampleableTests.allTests()
XCTMain(tests)