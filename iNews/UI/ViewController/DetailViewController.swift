//
//  DetailViewController.swift
//  iNews
//
//  Created by Toni De Gea on 7/2/22.
//

import UIKit
import AlamofireImage
import Alamofire

class DetailViewController: UIViewController {
    @IBOutlet weak var detailPhoto: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detaildate: UILabel!
    @IBOutlet weak var detailDescription: UITextView!
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        detailTitle.text = article?.title
        detailDescription.text = article?.articleDescription
        detaildate.text = article?.publishedAt.dateToSting
        if let image = article?.photoUrl {
            downloadPhoto(string: image)
        }
        
    }
    
    func downloadPhoto(string: String) {
        AF.request(string).responseImage { response in
            if case .success(let image) = response.result {
                self.detailPhoto.image = image
            }
        }
    }
}
