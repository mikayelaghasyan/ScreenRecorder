//
//  PNGScreenshotExporter.swift
//  ScreenRecorder
//
//  Created by Mikayel Aghasyan on 4/7/18.
//

import UIKit

public class PngScreenshotExporter: ScreenshotExporter {
    public init() {
    }

    public func exportScreenshot(screenshot: UIImage) -> Data {
        return UIImagePNGRepresentation(screenshot)!
    }

    public func fileExtension() -> String {
        return "png"
    }
}
