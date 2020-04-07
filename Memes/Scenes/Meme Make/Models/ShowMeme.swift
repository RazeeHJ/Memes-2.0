//
//  ShowMeme.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/3/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import UIKit

enum ShowMeme {
    struct DisplayedMeme {
        var topText:String
        var bottomText: String
        var memedImage: UIImage?
        
        init() {
            self.topText = ""
            self.bottomText = ""
            self.memedImage = nil
        }
    }
    
    enum GetMeme {
        struct Response {
            var memes: [Meme]?
            
            init(memes: [Meme]) {
                self.memes = memes
            }
        }
        
        struct ViewModel {
            var display: [DisplayedMeme]
        }
    }
}
