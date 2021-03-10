//
//  SeamLoginView.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 10/03/21.
//

import UIKit
@testable import TongoNews

final class SeamLoginView: LoginView {
    
    var configureSubviewsWasCalled = false
    
    override func configureSubviews() {
        super.configureSubviews()
        configureSubviewsWasCalled = true
    }
}
