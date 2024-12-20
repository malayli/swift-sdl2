import Foundation

/// Gets the font path.
func getFontPath() -> String {
    if let bundlePath = Bundle.module.path(forResource: "Arial", ofType: "ttf") {
        print("Found font in bundle: \(bundlePath)")
        return bundlePath
    }

    let relativePath = "Resources/Arial.ttf"
    if FileManager.default.fileExists(atPath: relativePath) {
        print("Found font in relative path: \(relativePath)")
        return relativePath
    }

    if let executablePath = Bundle.main.executablePath {
        let executableDir = (executablePath as NSString).deletingLastPathComponent
        let fontPath = (executableDir as NSString).appendingPathComponent("Resources/Arial.ttf")
        if FileManager.default.fileExists(atPath: fontPath) {
            print("Found font in executable directory: \(fontPath)")
            return fontPath
        }
    }

    let currentDirectoryPath = FileManager.default.currentDirectoryPath
    let projectFontPath = "\(currentDirectoryPath)/Resources/Arial.ttf"
    if FileManager.default.fileExists(atPath: projectFontPath) {
        print("Found font in project directory: \(projectFontPath)")
        return projectFontPath
    }

    fatalError("Could not find Arial.ttf in any location")
}
