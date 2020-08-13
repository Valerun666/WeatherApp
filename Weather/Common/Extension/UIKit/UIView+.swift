//
//  UIView+.swift
//  WeatherApp
//
//  Created by Valerii Teptiuk on 13.08.2020.
//  Copyright © 2020 Valerii Teptiuk. All rights reserved.
//

import UIKit

extension UIView {
    func layoutConstraintsToSuperview(padding: UIEdgeInsets = UIEdgeInsets.zero) {
        guard let superview = superview else { fatalError("unexpected state") }

        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom).isActive = true
        leftAnchor.constraint(equalTo: superview.leftAnchor, constant: padding.left).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -padding.right).isActive = true
    }
}
