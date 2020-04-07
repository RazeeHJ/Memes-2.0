//
//  MemeCollectionPresenter.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/3/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import Foundation

protocol MemeCollectionPresentationLogic {
    func present(with response: [ShowMeme.DisplayedMeme])
}

class MemeCollectionPresenter: MemeCollectionPresentationLogic {
    weak var viewController: MemeCollectionDisplayLogic?

    func present(with response: [ShowMeme.DisplayedMeme]) {
        let viewModel = ShowMeme.GetMeme.ViewModel(display: response)
        self.viewController?.display(with: viewModel)
    }
}
