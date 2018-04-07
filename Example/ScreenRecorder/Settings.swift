//
//  Settings.swift
//  ScreenRecorder_Example
//
//  Created by Mikayel Aghasyan on 4/7/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

struct Settings {
    public static let initial = Settings(imageDiffEnabled: false, imageFormat: .PNG)

    var imageDiffEnabled: Bool
    var imageFormat: ImageFormat

    init(imageDiffEnabled: Bool, imageFormat: ImageFormat) {
        self.imageDiffEnabled = imageDiffEnabled
        self.imageFormat = imageFormat
    }

    public enum ImageFormat : String, EnumCollection {
        case PNG = "PNG"
        case JPEG = "JPEG"
    }
}
