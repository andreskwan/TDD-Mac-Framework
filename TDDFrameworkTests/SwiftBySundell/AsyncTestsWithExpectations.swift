//
//  FromAsyncToSyncTests.swift
//  TDDFramework
//
//  Created by Andres Kwan on 6/04/22.
//
//

import XCTest

///
/// warning: https://www.swiftbysundell.com/articles/unit-testing-asynchronous-swift-code/
/// traditional way of testing asynchronous code.
///
class ImageScaler {
    func scale(_ images: [UIImage], _ closure: ([UIImage]) -> ()) {
        //the scaling process should take time
        //here is returning immediately
        closure(images)
    }
}

class UIImage {
}

class ImageScalerTests: XCTestCase {
    func testScalingProducesSameAmountOfImages() {
        let scaler = ImageScaler()
        let originalImages = loadImages()

        // Create an expectation
        let expectation = self.expectation(description: "Scaling")
        var scaledImages: [UIImage]?

        scaler.scale(originalImages) {
            scaledImages = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)

        XCTAssertEqual(scaledImages?.count, originalImages.count)
    }

    /// MARK: Helpers
    private func loadImages() -> [UIImage] {
        return []
    }
}
