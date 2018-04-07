//
//  ScreenshotTaker.swift
//  ScreenRecorder
//
//  Created by Mikayel Aghasyan on 4/7/18.
//

public protocol ScreenshotProcessor {
    func processScreenshot(screenshot: UIImage) -> UIImage
}
