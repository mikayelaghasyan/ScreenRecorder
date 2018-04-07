//
//  SettingsViewController.swift
//  ScreenRecorder_Example
//
//  Created by Mikayel Aghasyan on 4/7/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var settings: Settings!

    @IBOutlet var imageDiff: UISwitch!
    @IBOutlet var imageFormat: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageDiff.isOn = settings.imageDiffEnabled
        imageFormat.removeAllSegments()
        for format in Settings.ImageFormat.allValues {
            imageFormat.insertSegment(withTitle: format.rawValue, at: imageFormat.numberOfSegments, animated: false)
        }
        imageFormat.selectedSegmentIndex = Settings.ImageFormat.allValues.index(of: settings.imageFormat)!
    }

    @IBAction func imageDiffToggled(sender: UISwitch) {
        settings.imageDiffEnabled = sender.isOn
    }

    @IBAction func imageFormatSelected(sender: UISegmentedControl) {
        settings.imageFormat = Settings.ImageFormat.allValues[sender.selectedSegmentIndex]
    }
}
