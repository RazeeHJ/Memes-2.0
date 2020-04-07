//
//  MemeTableViewCell.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/3/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import UIKit

class MemeTableCell: UITableViewCell {
    static let Identifier = "MemeTableCell"
    @IBOutlet weak var memedImage: UIImageView!
    
    @IBOutlet weak var memedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with model: MemeTableCellModel) {
        print("MODEL: ", model)
        memedImage.image = model.displayedMeme.memedImage
    }
}

struct MemeTableCellModel {
    var displayedMeme: ShowMeme.DisplayedMeme
}
