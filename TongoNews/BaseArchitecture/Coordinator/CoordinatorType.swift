//
//  CoordinatorType.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 2/03/21.
//

protocol StartableCoordinator {
    func start() throws
}

protocol CoordinatorType: Routable, StartableCoordinator {
    associatedtype Node where Node: Hashable
    var nodeManager: [Node: Routable] { get }
    var currentNode: Node? { get }
    func setNode(node: Node, routable: Routable) throws
}
