//
//  MemeMakePresenter.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/5/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import Foundation

protocol MemeMakePresentationLogic {
    func present(with displayed: ShowMeme.DisplayedMeme)
}
class MemeMakePresenter: MemeMakePresentationLogic {
    weak var viewController: MemeMakeDisplayLogic?
    
    func present(with displayed: ShowMeme.DisplayedMeme) {
        viewController?.display(with: displayed)
    }
}
