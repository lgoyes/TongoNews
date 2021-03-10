//
//  ViewType.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 10/03/21.
//

import Foundation

protocol ViewType: AnyObject {
    init()
    func configureSubviews()
    static func getInstance() -> ViewType
}

extension ViewType {
    static func getInstance() -> ViewType {
        let newInstance = self.init()
        newInstance.configureSubviews()
        return newInstance
    }
}
