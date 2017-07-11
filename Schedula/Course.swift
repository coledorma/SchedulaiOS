//
//  Course.swift
//  SchedulaAlgorithm
//
//  Created by Cole Dorma on 2017-05-23.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import Foundation

public class Course {
    var code = ""
    var sections = [Section]()
    
    init(cod: String, sec: [Section]){
        code = cod
        sections = sec
    }
    
    public static func ==(lhs: Course, rhs: Course) -> Bool {
        return lhs.code == rhs.code
    }
    
    public func equals(other: Course?) -> Bool {
        if (other == nil) {
            return false
        }
        
        if (other! == self) {
            return true
        }
        
        if (!(other is Course)) {
            return false
        }
        
        let otherCourse = other
        
        return self.code == otherCourse!.code
    }
    
    public func toString() -> String {
        return "\(self.code)"
    }
    
}
