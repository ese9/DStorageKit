//
//  HeaderLabelView.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/11/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit
//import DStorageKit

class HeaderLabelView: UIView, XibLoadable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func onTapAction(_ sender: Any) {
        tapFlowDelegate?.onHeaderTapped()
    }
    
    weak var tapFlowDelegate: SectionTapDelegateProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXibFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXibFromNib()
    }
    
    public func changeTitle(with text: String) {
        titleLabel.text = text
    }
    
}
