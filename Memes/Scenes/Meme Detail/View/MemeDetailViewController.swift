//
//  MemeDetailViewController.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/6/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    static let Identifier = "MemeDetailViewController"
    
    @IBOutlet weak var image: UIImageView!
    var meme: ShowMeme.DisplayedMeme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()  {
        image.image = meme?.memedImage
    }
}
