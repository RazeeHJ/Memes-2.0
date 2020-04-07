//
//  MemeUtils.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 4/5/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import UIKit

class MemeAppDelegate {
    var appDelegate: AppDelegate
    
    init(appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    convenience init() {
        self.init(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    }
    
    func fetchMemes(resultCallback: @escaping ([Meme]) -> Void ) {
        print("APP DELEGATE: ", appDelegate.memes)
        resultCallback(appDelegate.memes)
    }
    
    func saveMemes(_ meme: Meme) {
        appDelegate.memes.append(meme)
    }
}
