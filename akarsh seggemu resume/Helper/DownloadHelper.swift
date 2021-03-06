//
//  DownloadHelper.swift
//  akarsh seggemu resume
//
//  Created by Akarsh Seggemu on 24/01/2019.
//  Copyright © 2019 Akarsh Seggemu. All rights reserved.
//

import Foundation

class DownloadHelper {
    // Download file from the URL and store it in the destination File URL
    fileprivate static func downloadData(_ sessionConfig: URLSession, _ request: URLRequest, _ destinationURL: URL) {
        // download task to download the resume JSON file
        let dataTask = sessionConfig.downloadTask(with: request) { data, _, error in
            if let error = error {
                print("Error while downloading a file: %@ \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print(error?.localizedDescription ?? "Response error")
                return
            }
            do {
                // copying the file to the destination file path
                try FileManager.default.copyItem(at: data, to: destinationURL)
            } catch let writeError {
                print("Error creating a file \(destinationURL) : \(writeError)")
            }
        }
        dataTask.resume()
    }
    // Conversion of the url data type from String to URL
    static func downloadFromURL(_ url: String, _ destinationFileUrl: URL) {
        guard let urlString = URL(string: url) else { return }
        let sessionConfig = URLSession(configuration: .default)
        let request = URLRequest(url: urlString)
        downloadData(sessionConfig, request, destinationFileUrl)
    }
}
