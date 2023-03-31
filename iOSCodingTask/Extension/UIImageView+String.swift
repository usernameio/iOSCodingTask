//
//  aaViewController.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 3/31/23.
//

import UIKit

extension UIImageView {
    //MARK: - Methods
    /// Sets up an ImageView with a url provided by the server.
    /// - Parameter urlString: The url in String format provided by the server
    func load(urlString: String) {
        let url = "http:" + urlString
        if let imageURL = URL(string: "\(url)") {
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
    
}
