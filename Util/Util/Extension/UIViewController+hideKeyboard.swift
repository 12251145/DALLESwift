//
//  UIViewController+hideKeyboard.swift
//  Util
//
//  Created by Hoen on 2023/03/22.
//

import UIKit

public extension UIViewController {
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func setupHideKeyboardOnTap() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}
