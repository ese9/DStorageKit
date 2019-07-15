//
//  SectionFlowProtocol.swift
//  DSStorageKit
//
//  Created by Roman Novikov on 6/19/19.
//  Copyright © 2019 SolbegSoft. All rights reserved.
//

import Foundation

public protocol SectionTapDelegateProtocol: class {
    func onHeaderTapped()
    func onFooterTapped()
}

extension SectionTapDelegateProtocol {
    func onHeaderTapped() {}
    func onFooterTapped() {}
}
