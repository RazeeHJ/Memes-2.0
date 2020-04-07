//
//  ViewController.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 2/25/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import UIKit

protocol MemeMakeDisplayLogic: class {
    func display(with displayed: ShowMeme.DisplayedMeme)
}
class MemeMakeViewController: UIViewController, UINavigationControllerDelegate {
    static let Identifier = "MemeMakeViewController"
   
    var interactor: MemeMakeBusinessLogic?
    var presenter: MemeMakePresentationLogic?
    var memeAppDelegate: MemeAppDelegate?
    var isReady = false
    
    @IBOutlet weak var toolbarTop: UIToolbar!
    @IBOutlet weak var toolbarBottom: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let pickerController = UIImagePickerController()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 75)!,
        NSAttributedString.Key.strokeWidth: NSNumber(value: -3.0 as Float)
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureCamera()
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        unsubscribeFromKeybordNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        construct(textField: topTextField, text: "TOP")
        construct(textField: bottomTextField, text: "BOTTOM")
    }
    
    func setup() {
        let viewController = self
        let interactor = MemeMakeInteractor()
        let presenter = MemeMakePresenter()
        
        viewController.interactor = interactor
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func pickImageFromAlbum(_ sender: Any) {
        clearMeme()
        configurePickerController(sourceType: .photoLibrary)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        clearMeme()
        configurePickerController(sourceType: .camera)
    }
    
    @IBAction func clearMeme(_ sender: Any) {
        clearMeme()
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let memedImage = generated()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed {
                self.save(memedImage)
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @available(iOS 13.0, *)
    final class DisabledDismissActivityViewController: UIActivityViewController {
        override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {}
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -KeyboardUtils.getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
}

extension MemeMakeViewController: UITextFieldDelegate {
    func construct(textField: UITextField, text: String) {
        textField.text = text
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func clearMeme() {
        construct(textField: topTextField, text: "TOP")
        construct(textField: bottomTextField, text: "BOTTOM")
        imageView.image = nil
    }
}

extension MemeMakeViewController: UIImagePickerControllerDelegate {
    func configurePickerController(sourceType: UIImagePickerController.SourceType) {
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFill
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension MemeMakeViewController {
    func configureCamera() {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func enableToolBarsAndNavigationBar(value: Bool) {
        toolbarTop.isHidden = value
        toolbarBottom.isHidden = value
        navigationBar.isHidden = value
    }
}

extension MemeMakeViewController {
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeybordNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension MemeMakeViewController {
    func save(_ memedImage: UIImage) {
        let meme = Meme(topText: topTextField.text ?? "" , bottomText: bottomTextField.text ?? "", originalImage: imageView.image!, memedImage: memedImage)
        
        interactor?.insertMeme(meme: meme)
    }
    
    func generated() -> UIImage {
        enableToolBarsAndNavigationBar(value: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawHierarchy(in: self.imageView.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        enableToolBarsAndNavigationBar(value: false)
        return memedImage
    }
}

extension MemeMakeViewController: MemeMakeDisplayLogic {
    func display(with displayed: ShowMeme.DisplayedMeme) {}
}
