//
//  MemeCollectionViewController.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/3/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import UIKit

protocol MemeCollectionDisplayLogic: class {
    func display(with viewModel: ShowMeme.GetMeme.ViewModel)
}

class MemeCollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var interactor: MemeCollectionBusinessLogic?
    var presenter: MemeCollectionPresentationLogic?
    
    var displayedMemes: [ShowMeme.DisplayedMeme] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.interactor?.getMemes()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerViewCell()
        configureCollectionView()
        setupFlowLayout()
        setupNavigatioItem()
    }
    
    func setup() {
        let viewController = self
        let interactor = MemeCollectionInteractor()
        let presenter = MemeCollectionPresenter()
        
        viewController.interactor = interactor
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    func setupNavigatioItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMemeMaker))
    }
}

extension MemeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.displayedMemes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCollectionCell.Identifier, for: indexPath) as! MemeCollectionCell
        
        let displayModel = displayedMemes[indexPath.row]
        let model = MemeCollectionCellModel(displayedMeme: displayModel)
        cell.configure(with: model)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: MemeDetailViewController.Identifier) as! MemeDetailViewController
        detailController.meme = displayedMemes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)    }
}

extension MemeCollectionViewController {
    func registerViewCell() {
        let memeCellNib = UINib(nibName: MemeCollectionCell.Identifier, bundle: nil)
        collectionView.register(memeCellNib, forCellWithReuseIdentifier: MemeCollectionCell.Identifier)
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupFlowLayout() {
        let space:CGFloat = 3.0
        let dimensionWidth = (view.frame.size.width - (2 * space)) / space
        let dimensionHeight = (view.frame.size.height - (2 * space)) / 8.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimensionWidth, height: dimensionHeight)
    }
}

extension MemeCollectionViewController {
    @objc func showMemeMaker() {
        let memeMakeViewController = self.storyboard!.instantiateViewController(withIdentifier: MemeMakeViewController.Identifier) as! MemeMakeViewController
        
        memeMakeViewController.modalPresentationStyle = .fullScreen
        self.present(memeMakeViewController, animated: true, completion: nil)
    }
}
extension MemeCollectionViewController: MemeCollectionDisplayLogic  {
    func display(with viewModel: ShowMeme.GetMeme.ViewModel) {
        self.displayedMemes = viewModel.display
        collectionView.reloadData()
    }
}
