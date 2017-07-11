//
//  SubSection.swift
//  SchedulaAlgorithm
//
//  Created by Cole Dorma on 2017-05-18.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import Foundation

class SubSection: Section {
    
    var holder = ""
    var subSectionParam = [SubSection]()
    
    init(s: String?, t: String, c: Int, tr: Int, time: String){
        super.init(n: s!, p: t, c: c, term: tr, time: time, s: subSectionParam)
    }
    
}
