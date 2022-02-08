//
//  ArticlesTableViewCell.swift
//  iNews
//
//  Created by Toni De Gea on 7/2/22.
//

import UIKit
import Alamofire
import AlamofireImage

class ArticlesTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: ArticlesTableViewCell.self)
    
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var imageCellView: UIImageView!
    @IBOutlet weak var titleCellView: UILabel!
    @IBOutlet weak var descriptionCellView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleCellView.text = ""
        descriptionCellView.text = ""
        mView.layer.cornerRadius = 8
        mView.layer.masksToBounds = true
        imageCellView.layer.cornerRadius = 4
        imageCellView.clipsToBounds = true
        mView.layer.masksToBounds = false
        mView.layer.shadowColor = UIColor.black.cgColor
        mView.layer.shadowOpacity = 0.23
        mView.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(title: String, description: String, image: String?) {
        titleCellView.text = title
        descriptionCellView.text = description
        if let image = image {
            downloadImage(string: image)
        }
    }
    
    func downloadImage(string: String) {
        AF.request(string).responseImage { response in
            if case .success(let image) = response.result {
                self.imageCellView.image = image
            }
        }

    }
}
