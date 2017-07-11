//
//  Node.swift
//  SchedulaAlgorithm
//
//  Created by Cole Dorma on 2017-05-23.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import Foundation

//Cite: https://hugotunius.se/2016/07/17/implementing-a-linked-list-in-swift.html

public class Node<T: Equatable> {
    typealias NodeType = Node<T>
    
    /// The value contained in this node
    public let value: T
    var next: NodeType? = nil
    var previous: NodeType? = nil
    
    public init(value: T) {
        self.value = value
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        get {
            return "Node(\(value))"
        }
    }
}
