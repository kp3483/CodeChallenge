//
//  UIView=extensions.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/12/22.
//

import Foundation
import UIKit

extension UIView {
    func layout(using constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
