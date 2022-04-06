//
//  FromAsyncToSyncTests.swift
//  TDDFramework
//
//  Created by Andres Kwan on 6/04/22.
//
//

import XCTest

class ImageScaler {
    func scale(_ images: [UIImage], _ closure: ([UIImage]) -> ()) {

    }
}

class UIImage {
}

class ImageScalerTests: XCTestCase {
    func testScalingProducesSameAmountOfImages() {
        let scaler = ImageScaler()
        let originalImages = loadImages()

        scaler.scale(originalImages) { scaledImages in
            XCTAssertEqual(scaledImages.count, originalImages.count)
        }
    }

    /// MARK: Helpers
    private func loadImages() -> [UIImage] {
        return []
    }
}
