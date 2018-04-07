//
//  DiffScreenshotProcessor.swift
//  ScreenRecorder
//
//  Created by Mikayel Aghasyan on 4/7/18.
//

import UIKit

public class DiffScreenshotProcessor: ScreenshotProcessor {
    var lastScreenshot: UIImage?
    
    public init() {
    }

    public func processScreenshot(screenshot: UIImage) -> UIImage {
        var result: UIImage?
        if let lastScreenshot = lastScreenshot {
            result = createDiffImage(minuend: lastScreenshot, subtrahend: screenshot)
        } else {
            result = screenshot
        }
        lastScreenshot = screenshot
        return result!
    }

    func createDiffImage(minuend: UIImage, subtrahend: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(minuend.size, false, minuend.scale)
        minuend.draw(in: CGRect(origin: .zero, size: minuend.size))
        subtrahend.draw(in: CGRect(origin: .zero, size: subtrahend.size), blendMode: .difference, alpha: 1)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
}
