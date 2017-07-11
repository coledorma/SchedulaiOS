//
//  Commitment.swift
//  SchedulaAlgorithm
//
//  Created by Cole Dorma on 2017-05-23.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import Foundation

public class Commitment {
    
    var type = ""
    var term = 0
    var times = SubSection(s: "", t: "", c: 0, tr: 0, time: "W 1405-1605")
    
    init(typ: String, ter: Int, tim: String){
        type = typ
        term = ter
        
        times = SubSection(s: "", t: typ, c: 0, tr: ter, time: tim)
        
    }
    
    func getTimes() -> SubSection {
        return times
    }
    
    public func getType() -> String	{
        return type
    }
    
    public func getTerm() -> Int {
        return term
    }
    
    public func toString() -> String {
        return times.toString()
    }
    
    public static func ==(lhs: Commitment, rhs: Commitment) -> Bool {
        return lhs.times == rhs.times
    }
}
