//
//  DownloadManager.swift
//  FromEKBCity
//
//  Created by Фаниль on 18.06.2024.
//

import UIKit

class DownloadManager {
    static var shared = DownloadManager()
    
    private init() {}
    
    func downloadFile(from url: String, allLinks: Bool, completion: ((_ images: [String]) -> Void)?) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Error downloading file: \(error.localizedDescription)")
                return
            }
            guard let data, let content = String(data: data, encoding: .utf8) else {
                print("Error reading file data")
                return
            }
            let images = self.extractValidLinks(from: content, allLinks: allLinks)
            completion?(images)
        }
        task.resume()
    }
    
    func extractValidLinks(from content: String, allLinks: Bool) -> [String] {
        let lines = content.split(separator: "\n").map { String($0) }
        if allLinks {
            return lines
        } else {
            return lines.filter { link in
                return link.contains("images") || (link.contains("jpg") || link.contains("png"))
            }
        }
    }
}
