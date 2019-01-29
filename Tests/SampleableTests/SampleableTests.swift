import XCTest
@testable import Sampleable

final class SampleableTests: XCTestCase {
    func test_SimpleComposition() {
		let composedSamples = String.samples(using: String.self, Int.self) { string, int in
			return "\(string)\(int)"
		}

		XCTAssertEqual(composedSamples, ["A1", "B2"])
    }
}

extension Int: Sampleable {
	public static var sample: Int { return samples[0] }

	public static var samples: [Int] {
		return [1, 2, 3, 4]
	}
}

extension String: Sampleable {
	public static var sample: String { return samples[0] }

	public static var samples: [String] {
		return ["A", "B"]
	}
}
