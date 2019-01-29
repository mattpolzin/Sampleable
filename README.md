# Sampleable

A lightweight protocol for describing types that can provide samples of themselves.

## Usage

`Sampleable` requires one static method of its conformers.

```swift
static var sample: Self { get }
```

This method simply returns a sample value of the conforming Type.

A `Sampleable` Type can then go on to provide any of the optional methods that otherwise have sensible default implementations.

```swift
static var successSample: Self? { get }

static var failureSample: Self? { get }

static var samples: [Self] { get }
```

The first two default to `nil` and the third defaults to an array containing only the value returned by `Self.sample`.

In addition to providing a standard way to provide samples, the `Sampleable` protocol provides a series of static functions that can be used to compose samples from other `Sampleable` Types via an extension. The real beauty of these functions is that they take a closure that constructs `Self` given samples of a number of other things and they pass it one sample of each input Type until input Type samples are exhausted. In turn, they produce an array of `Self`. This is hard to explain, but hopefully the following example will shed light on the operation. If it helps to think of it this way, the operation being performed is essentially `zipWith` where each input Type's samples are zipped with the constructor of `Self`.

Consider the following three `Sampleable` conformers.

```swift
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
```

Note that `String` provides two samples whereas `Int` provides four samples. This is important because the following operation (much like `zipWith`) will stop when it reaches the end of the shortest array of samples.

```swift
let composedSamples = String.samples(using: String.self, Int.self) { string, int in
  return "\(string)\(int)"
}
```

This will produce the array of `Strings` `["A1", "B2"]`. Notice that it took the first sample from each input Type and passed it to the closure, then it did the same with the second sample from each input Type, and then it was out of samples from the first input Type so it was done.

This type of composition can be done with up to 8 input types out-of-box (you can add more yourself, of course) and there is nothing special about the first input Type matching the result Type in the example, this is entirely incidental.
