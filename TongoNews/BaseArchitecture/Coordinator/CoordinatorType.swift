//
//  CoordinatorType.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 2/03/21.
//

protocol CoordinatorType: Routable {
    func start() throws
    func setNode<T: RoutableNode>(node: T, routable: Routable) throws
}
