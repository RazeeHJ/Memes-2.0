//
//  Mapper.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/3/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import Foundation

protocol MapperDisplayLogic {
    func mapToDisplayModel(from meme: Meme) -> ShowMeme.DisplayedMeme
}

class Mapper {
    func mapToDisplayModel(from meme: Meme) -> ShowMeme.DisplayedMeme {
        var display = ShowMeme.DisplayedMeme()
        display.topText = meme.topText
        display.bottomText = meme.bottomText
        display.memedImage = meme.memedImage

        return display
    }
}
