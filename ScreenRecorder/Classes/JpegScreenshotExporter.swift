//
//  JpegScreenshotExporter.swift
//  ScreenRecorder
//
//  Created by Mikayel Aghasyan on 4/7/18.
//

import UIKit

public class JpegScreenshotExporter: ScreenshotExporter {
    public init() {
    }
    
    public func exportScreenshot(screenshot: UIImage) -> Data {
        return UIImageJPEGRepresentation(screenshot, 1)!
    }

    public func fileExtension() -> String {
        return "jpeg"
    }
}
