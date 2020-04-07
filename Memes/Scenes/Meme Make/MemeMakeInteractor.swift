//
//  MemeMakeInteractor.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/4/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import Foundation

protocol MemeMakeBusinessLogic {
    func insertMeme(meme: Meme)
}
class MemeMakeInteractor: MemeMakeBusinessLogic {
    var presenter: MemeMakePresentationLogic?
    var memeAppDelegate = MemeAppDelegate()

    var mapper = Mapper()
    
    init() {}
    
    func insertMeme(meme: Meme) {
        self.memeAppDelegate.saveMemes(meme)
        
        self.presenter?.present(with: self.mapper.mapToDisplayModel(from: meme))
    }
}
