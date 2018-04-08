//
//  NewsListViewController.swift
//  ScreenRecorder_Example
//
//  Created by Mikayel Aghasyan on 4/6/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyJSON
import ScreenRecorder

class ArticleListViewController: UITableViewController {
    var articles: [JSON]!;

    var settings = Settings.initial
    
    var session: RecordingSession? {
        didSet {
            settingsButton.isEnabled = (session == nil)
            controlButton.image = (session == nil ? UIImage(named: "ic_play_arrow") : UIImage(named: "ic_stop"))
        }
    }

    @IBOutlet var settingsButton: UIBarButtonItem!
    @IBOutlet var controlButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        guard let jsonData = try? Data(contentsOf: url) else { return }
        guard let jsonResult = try? JSON(data: jsonData) else { return }
        self.articles = jsonResult["articles"].array
    }

    @IBAction func settingsPressed(sender: UIBarButtonItem) {
    }
    
    @IBAction func controlPressed(sender: UIBarButtonItem) {
        if session == nil {
            startSession()
        } else {
            stopSession()
        }
    }

    func startSession() {
        var processor: ScreenshotProcessor?
        if (self.settings.imageDiffEnabled) {
            processor = DiffScreenshotProcessor()
        } else {
            processor = PlainScreenshotProcessor()
        }
        let exporter = screenshotExporter(for: self.settings.imageFormat)
        session = RecordingSession(processor: processor!, exporter: exporter, window: self.view.window!)
        session?.start()
    }

    func screenshotExporter(for format: Settings.ImageFormat) -> ScreenshotExporter {
        switch format {
        case .PNG:
            return PngScreenshotExporter()
        case .JPEG:
            return JpegScreenshotExporter()
        }
    }

    func stopSession() {
        session?.stop() {
            session = nil
        }
    }

    @IBAction func unwindToArticleList(segue:UIStoryboardSegue) {
        if let settingsViewController = segue.source as? SettingsViewController {
            self.settings = settingsViewController.settings
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.article = self.articles[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "ArticleDetails":
            let detailsViewController = segue.destination as! ArticleDetailsViewController
            let cell = sender as! ArticleCell
            detailsViewController.article = cell.article
        case "Settings":
            let navController = segue.destination as! UINavigationController
            let settingsViewController = navController.topViewController as! SettingsViewController
            settingsViewController.settings = settings
        default:
            break
        }
    }
}
