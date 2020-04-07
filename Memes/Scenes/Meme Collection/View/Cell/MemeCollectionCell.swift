//
//  MemeCollectionCell.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/4/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import UIKit

class MemeCollectionCell: UICollectionViewCell {
    static let Identifier = "MemeCollectionCell"
    
    @IBOutlet weak var memedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with model: MemeCollectionCellModel) {
        self.memedImage.image = model.displayedMeme.memedImage
    }
}

struct MemeCollectionCellModel {
    var displayedMeme: ShowMeme.DisplayedMeme
}
