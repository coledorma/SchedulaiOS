//
//  Schedule.swift
//  SchedulaAlgorithm
//
//  Created by Cole Dorma on 2017-05-23.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import Foundation

public class Schedule {
    
    var sections = [Section]()
    var size = 0
    
    init(){
        sections = [Section]()
    }
    
    public func getSize() -> Int {
        return size
    }
    
    public func getSections() -> LinkedList<Section> {
        let returnSec = LinkedList(sections)
        return returnSec
    }
    
    
    public func equals(other: Schedule?) -> Bool {
        if (other == nil){
            return false
        }
        
        if (other! == self) {
            return true
        }
        
        if (!(other is Schedule)) {
            return false
        }
        
        let otherSched = other
        
        var elementsInCommon = 0;
        
        for s in self.sections{
            if (otherSched?.sections.contains(s))!{
                elementsInCommon += 1
            }
        }
        
        return otherSched!.size == elementsInCommon;
    }
    
    public func add(s: Section) -> Bool {
        for inSched in sections{
            if (inSched.conflicts(s: s)) {
                return false
            }
        }
        
        var matches = false
        
        if !(sections.contains(s)) {
            sections.append(s)
            matches = true
        }
        
        if (matches == true) {
            size += 1
        }
        
        return matches
        
    }
    
    public func contains(s: Section) -> Bool {
        return sections.contains(s)
    }
    
    public func toString() -> String {
        var final = ""
        for index in 0...sections.count-1{
            final += " index: \(index) "
            final += sections[index].toString()
        }
        return final
    }
    
}

extension Schedule: Equatable {}

public func ==(lhs: Schedule, rhs: Schedule) -> Bool {
    var sameCount = 0
    for i in 0...lhs.sections.count - 1{
        for j in 0...rhs.sections.count - 1{
            if lhs.sections[i].crn == rhs.sections[j].crn {
                sameCount += 1
                if sameCount >= lhs.sections.count && sameCount >= rhs.sections.count {
                    print("EQUAL")
                    return true
                }
                break
            }
        }
    }
    
    return false
}
