//
//  ArticleCell.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(image: String, name: String, desc: String) {
        self.name.text = name
        self.desc.text = desc
        
        let formattedString = image.replacingOccurrences(of: " ", with: "%20")
        imageArticle.sd_setImage(with: URL(string: formattedString)) {[weak self] img, _, _, _ in
            guard let self = self else {return}
            if let _ = img{
            } else {
                self.imageArticle.image = UIImage(named: "")
            }
        }
    }
    
}
