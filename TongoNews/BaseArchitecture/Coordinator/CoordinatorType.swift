//
//  CoordinatorType.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 2/03/21.
//

protocol CoordinatorType: Routable {
    associatedtype Node where Node: RoutableNode, Node: Hashable
    var nodeManager: [Node: Routable] { get }
    var currentNode: Node? { get }
    func start() throws
    func setNode(node: Node, routable: Routable) throws
}
