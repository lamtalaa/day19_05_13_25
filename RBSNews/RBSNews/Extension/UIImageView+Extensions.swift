//
//  UIImageView+Extensions.swift
//  RBSNews
//
//  RBS Tests Project on 12/10/20.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
		
        let dataTask1 = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let _data = data, error == nil
                else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: _data)
                    self.image = image
            }
        }
        dataTask1.resume()
    }
	
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
