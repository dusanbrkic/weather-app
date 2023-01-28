//
//  LocalURLBuilder.swift
//  Weather App
//
//  Created by Dusan Brkic on 17.8.22..
//

import Foundation
import UIKit

class LocalURLBuilder {
    func buildURLToAssets(with filename: String, of fileType: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(filename).\(fileType)")

        guard fileManager.fileExists(atPath: url.path) else {
            guard let video = NSDataAsset(name: filename)  else { return nil }
            fileManager.createFile(atPath: url.path, contents: video.data, attributes: nil)
            return url
        }
        return url
    }
}
