//
//  UIView.swift
//  ColorSlider
//
//  Created by Roman Novikov on 5/31/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import Foundation
import UIKit



protocol XibLoadable: UIView { }

extension XibLoadable {
    func loadXibFromNib() {
        let instance: Self = self
        let bundle = Bundle(for: type(of: instance.self))
        let nib = UINib(nibName: String(describing: Self.self), bundle: bundle)
        let view = nib.instantiate(withOwner: instance, options: nil)
        guard let validView = view.first as? UIView else {
            fatalError("XibLoadable: Failed to load view from nib \(String(describing: Self.self))")
        }
        
        validView.frame = instance.bounds
        instance.addSubview(validView)
    }
    
    func loadXibView() -> Self {
        guard let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)?.first as? Self else {
            fatalError("XibLoadable: Failed to load xib view \(String(describing: Self.self))")
        }
        self.addSubview(view)
        return view
    }
}
