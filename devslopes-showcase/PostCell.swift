//
//  PostCell.swift
//  devslopes-showcase
//
//  Created by Tobias Gozzi on 12/10/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit
import Alamofire

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    var request: Request?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
        
        showcaseImg.clipsToBounds = true
    }

    func configureCell(post: Post, image: UIImage?) {
        self.post = post
        
        self.descriptionText.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
        if post.imageUrl != nil {
            
            if image != nil {
                showcaseImg.image = image
            } else {
                request = Alamofire.request(.GET, post.imageUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                    
                    if err == nil {
                        if let imgData = data {
                            let img = UIImage(data: imgData)
                            self.showcaseImg.image = img
                            FeedVC.imgCache.setObject(imgData, forKey: self.post.imageUrl!)
                        }
                    }
                })
            }
            
        } else {
            self.showcaseImg.hidden = true
        }
    }
}
