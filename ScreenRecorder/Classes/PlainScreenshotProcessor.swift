//
//  PlainScreenshotProcessor.swift
//  ScreenRecorder
//
//  Created by Mikayel Aghasyan on 4/7/18.
//

import UIKit

public class PlainScreenshotProcessor: ScreenshotProcessor {
    public init() {
    }

    public func processScreenshot(screenshot: UIImage) -> UIImage {
        return screenshot
    }
}
