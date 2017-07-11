//
//  LinkedList.swift
//  SchedulaAlgorithm
//
//  Created by Cole Dorma on 2017-05-23.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import Foundation

public final class LinkedList<T: Equatable> {
    public typealias NodeType = Node<T>
    
    fileprivate var start: NodeType? {
        didSet {
            // Special case for a 1 element list
            if end == nil {
                end = start
            }
        }
    }
    
    fileprivate var end: NodeType? {
        didSet {
            // Special case for a 1 element list
            if start == nil {
                start = end
            }
        }
    }
    
    /// The number of elements in the list at any given time
    public fileprivate(set) var count: Int = 0
    
    /// Wether or not the list is empty. Returns `true` when
    /// count is 0 and `false` otherwise
    public var isEmpty: Bool {
        get {
            return count == 0
        }
    }
    
    /// Create a new LinkedList
    ///
    /// - returns: An empty LinkedList
    public init() {
        
    }
    
    public func append(value: T) {
        let previousEnd = end
        end = NodeType(value: value)
        
        end?.previous = previousEnd
        previousEnd?.next = end
        
        count += 1
    }
    
    private func iterate(block: (_ node: NodeType, _ index: Int) throws -> NodeType?) rethrows -> NodeType? {
        var node = start
        var index = 0
        
        while node != nil {
            let result = try block(node!, index)
            if result != nil {
                return result
            }
            index += 1
            node = node?.next
        }
        
        return nil
    }
    
    public func nodeAt(index: Int) -> NodeType {
        precondition(index >= 0 && index < count, "Index \(index) out of bounds")
        
        let result = iterate {
            if $1 == index {
                return $0
            }
            
            return nil
        }
        
        return result!
    }
    
    public func valueAt(index: Int) -> T {
        let node = nodeAt(index: index)
        return node.value
    }
    
    public func contains(value: T) -> Bool {
        var currNode = start
        
        while currNode?.next != nil {
            print("CURRNODE: \(String(describing: currNode?.value))")
            print("VALUE: \(value)")
            if (currNode?.value == value) || (currNode?.next?.value == value) {
                print("values equal")
                return true
            } else {
                currNode = currNode?.next
            }
        }
        
        return false
        
    }
    
    /// Remove a give node from the list
    ///
    /// - complexity: O(1)
    /// - parameter node: The node to remove
    public func remove(node: NodeType) {
        let nextNode = node.next
        let previousNode = node.previous
        
        if node === start && node === end {
            start = nil
            end = nil
        }
        else if node === start {
            start = node.next
        } else if node === end {
            end = node.previous
        } else {
            previousNode?.next = nextNode
            nextNode?.previous = previousNode
        }
        
        count -= 1
        assert(
            (end != nil && start != nil && count >= 1) || (end == nil && start == nil && count == 0),
            "Internal invariant not upheld at the end of remove"
        )
    }
    
    public func remove(atIndex index: Int) {
        precondition(index >= 0 && index < count, "Index \(index) out of bounds")
        
        // Find the node
        let result = iterate {
            if $1 == index {
                return $0
            }
            return nil
        }
        
        // Remove the node
        remove(node: result!)
    }
    
    /// Create a new LinkedList with a sequence
    ///
    /// - parameter: A sequence
    /// - returns: A LinkedList containing the elements of the provided      sequence
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        for element in elements {
            append(value: element)
        }
    }
}

public struct LinkedListIterator<T: Equatable>: IteratorProtocol {
    public typealias Element = Node<T>
    
    /// The current node in the iteration
    private var currentNode: Element?
    
    fileprivate init(startNode: Element?) {
        currentNode = startNode
    }
    
    public mutating func next() -> LinkedListIterator.Element? {
        let node = currentNode
        currentNode = currentNode?.next
        
        return node
    }
}
extension LinkedList: Sequence {
    public typealias Iterator = LinkedListIterator<T>
    
    public func makeIterator() -> LinkedList.Iterator {
        return LinkedListIterator(startNode: start)
    }
}


