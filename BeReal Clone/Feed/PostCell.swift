//
//  PostCell.swift
//  BeReal Clone
//
//  Created by AJ on 3/1/23.
//

import UIKit
import Alamofire
import AlamofireImage
import InitialsImageView

class PostCell: UITableViewCell {
    
    @IBOutlet private weak var pf_pick: UIImageView!
    
    @IBOutlet private weak var usernameLabel: UILabel!
    
    @IBOutlet private weak var DateLabel: UILabel!
    
    @IBOutlet private weak var postImageView: UIImageView!
    
    @IBOutlet private weak var captionLabel: UILabel!
    
    private var imageDataRequest: DataRequest?
    
    
    func configure(with post: Post){
        
        
        if let user = post.user{
            usernameLabel.text = user.username
            
            
            
            let pf_picks: UIImageView = UIImageView.init(frame: CGRect(x: self.contentView.bounds.midX - 170, y: self.contentView.bounds.midY - 200, width: 50, height: 50))
                  
                    
            pf_picks.setImageForName(user.username ?? "NA", circular: true, textAttributes: nil, gradient: true)
            
            pf_pick.image = pf_picks.image
            
            
            }
        
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.postImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }
        
        
        
        
        
        
        
        
        captionLabel.text = post.caption

        // Date
        if let date = post.createdAt {
            DateLabel.text = DateFormatter.postFormatter.string(from: date)
        }
        
        
    }
    
    
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: P1 - Cancel image download
        // Reset image view image.
        postImageView.image = nil

        // Cancel image request.
        imageDataRequest?.cancel()
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
