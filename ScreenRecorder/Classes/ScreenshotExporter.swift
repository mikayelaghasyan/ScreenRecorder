//
//  ScreenshotExporter.swift
//  ScreenRecorder
//
//  Created by Mikayel Aghasyan on 4/7/18.
//

public protocol ScreenshotExporter {
    func exportScreenshot(screenshot: UIImage) -> Data
    func fileExtension() -> String
}
