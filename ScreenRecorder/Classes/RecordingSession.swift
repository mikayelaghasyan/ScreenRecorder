//
//  RecordingSession.swift
//  ScreenRecorder
//
//  Created by Mikayel Aghasyan on 4/7/18.
//

public class RecordingSession {
    let screenshotProcessor: ScreenshotProcessor
    let screenshotExporter: ScreenshotExporter
    let window: UIWindow

    let sessionId: String
    var currentSnapshot: Int = 0
    var timer: DispatchSourceTimer?
    
    
    public init(processor: ScreenshotProcessor, exporter: ScreenshotExporter, window: UIWindow) {
        self.screenshotProcessor = processor
        self.screenshotExporter = exporter
        self.window = window
        self.sessionId = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        createSessionDirectory()
    }

    public func start() {
        scheduleScreenshotTimer()
    }

    func createSessionDirectory() {
        let dirUrl = sessionDirectoryUrl()
        try? FileManager.default.createDirectory(atPath: dirUrl.path, withIntermediateDirectories: true, attributes: nil)
    }

    func sessionDirectoryUrl() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("Recordings").appendingPathComponent(self.sessionId)
    }

    func scheduleScreenshotTimer() {
        stop {
            timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            timer?.schedule(deadline: .now(), repeating: .seconds(1))
            timer?.setEventHandler { [weak self] in
                guard let screenshot = self?.takeScreenshot() else { return }
                DispatchQueue.global(qos: .background).async {
                    guard let processed = self?.screenshotProcessor.processScreenshot(screenshot: screenshot) else { return }
                    guard let data = self?.screenshotExporter.exportScreenshot(screenshot: processed) else { return }
                    if self?.saveImageData(data: data) ?? false {
                        self?.currentSnapshot += 1
                    }
                }
            }
            timer?.resume()
        }
    }

    func takeScreenshot() -> UIImage? {
        var result: UIImage?
        UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, false, 0)
        if self.window.drawHierarchy(in: self.window.bounds, afterScreenUpdates: true) {
            result = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return result
    }

    func saveImageData(data: Data) -> Bool {
        let dirUrl = sessionDirectoryUrl()
        let fileUrl = dirUrl.appendingPathComponent("Screenshot-\(currentSnapshot)").appendingPathExtension(self.screenshotExporter.fileExtension())
        return FileManager.default.createFile(atPath: fileUrl.path, contents: data)
    }

    public func stop(callback: () -> Void) {
        timer?.cancel()
        callback()
    }
}
