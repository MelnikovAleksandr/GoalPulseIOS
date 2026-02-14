//
//  UINavigationController.swift
//  Utils
//
//  Created by Александр Мельников on 06.02.2026.
//

import UIKit

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
