import UIKit
import Swift

var sum: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
    return a + b
}

var sumResult: Int = sum(1, 2)
print(sumResult)
