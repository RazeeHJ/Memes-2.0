//
//  MemeTableViewController.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/3/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import Foundation
import UIKit

private let HEIGHTFORCELL = CGFloat(150)

protocol MemeTableDisplayLogic: class {
    func display(with viewModel: ShowMeme.GetMeme.ViewModel)
}
class MemeTableController: UITableViewController {    
    var interactor: MemeTableBusinessLogic?
    var presenter: MemeTablePresentationLogic?
    
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
        configureTableView()
        
        setupNavigatioItem()
    }
    
    func setup() {
        let viewController = self
        let interactor = MemeTableInteractor()
        let presenter = MemeTablePresenter()
        
        viewController.interactor = interactor
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    func setupNavigatioItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMemeMaker))
    }
}

extension MemeTableController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedMemes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HEIGHTFORCELL
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemeTableCell.Identifier, for: indexPath) as! MemeTableCell
        
        let displayModel = displayedMemes[indexPath.row]
        let model = MemeTableCellModel(displayedMeme: displayModel)
        cell.configure(with: model)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: MemeDetailViewController.Identifier) as! MemeDetailViewController
        detailController.meme = displayedMemes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}

extension MemeTableController {
    func registerViewCell() {
        let memeCellNib = UINib(nibName: MemeTableCell.Identifier, bundle: nil)
        tableView.register(memeCellNib, forCellReuseIdentifier: MemeTableCell.Identifier)
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MemeTableController {
    @objc func showMemeMaker() {
        let memeMakeViewController = self.storyboard!.instantiateViewController(withIdentifier: MemeMakeViewController.Identifier) as! MemeMakeViewController
        
        memeMakeViewController.modalPresentationStyle = .fullScreen
        self.present(memeMakeViewController, animated: true, completion: nil)
    }
}

extension MemeTableController: MemeTableDisplayLogic {
    func display(with viewModel: ShowMeme.GetMeme.ViewModel) {
        self.displayedMemes = viewModel.display
        print("displayed memes: ", self.displayedMemes)
        tableView.reloadData()
    }
}
