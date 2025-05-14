//
//  NewsTableViewCell.swift
//  RBSNews
//
//  RBS Tests Project on 12/10/20.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
	@IBOutlet weak var newsThumbnail: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupNewsCell(source:String?, title:String) {
        self.newsSourceLabel.text = source
        self.newsTitleLabel.text = title
    }

    func setupNewsImage(imageURL:String) {
        newsImageView.downloaded(from: imageURL)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
