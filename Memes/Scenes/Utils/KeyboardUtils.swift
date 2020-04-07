//
//  KeyboardUtils.swift
//  Memes
//
//  Created by Razee Hussein-Jamal on 3/23/20.
//  Copyright © 2020 Razee Hussein-Jamal. All rights reserved.
//

import UIKit

class KeyboardUtils {
    static func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
