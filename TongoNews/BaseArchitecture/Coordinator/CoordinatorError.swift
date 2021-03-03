//
//  CoordinatorError.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 2/03/21.
//

import Foundation

enum CoordinatorError: Error {
    case nodeIsNotDefined
    case nodeIsNotCoordinatorType
    case unableToSetRoutableNode
}
