//
//  MemeTableInteractor.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/3/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import Foundation
import UIKit

protocol MemeTableBusinessLogic {
    func getMemes()
}
class MemeTableInteractor: MemeTableBusinessLogic {
    var presenter: MemeTablePresentationLogic?
    var memeAppDelegate = MemeAppDelegate()
    
    var mapper = Mapper()
    private var memes: [Meme] = []
    var mapperItem: [ShowMeme.DisplayedMeme] = []

    init() {}
    
    func getMemes() {
        self.memeAppDelegate.fetchMemes { (memes: [Meme]) in
            self.memes = memes
        }

        mapperItem = []
        for meme in memes {
            mapperItem.append(mapper.mapToDisplayModel(from: meme))
        }
        presenter?.present(with: mapperItem)
    }
}
