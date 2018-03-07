//
//  ScheduleGenerator.swift
//  SchedulaAlgorithm
//
//  Created by Cole Dorma on 2017-05-24.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import Foundation

public class ScheduleGenerator {
    var schedules = LinkedList<Schedule>()
    var courses = [Course]()
    var commits = [Commitment]()
    var periods = [String]();
    var generator = Int(arc4random())
    
    init(cr: [Course], cm: [Commitment], p: [String], size: Int, prefOnline: Bool){
        if (prefOnline){
            courses = [Course]()
            for c in cr {
                let sects = Course(cod: c.code, sec: [Section]());
                for s in c.sections {
                    if (s.numDays() == 0) {
                        sects.sections.append(s)
                    }
                }
                if (!sects.sections.isEmpty) {
                    courses.append(sects)
                } else {
                    courses.append(c);
                }
            }
        } else {
            courses = cr;
        }
        commits = cm;
        periods = p;
        schedules = LinkedList<Schedule>()
        generator = Int(arc4random())
        let startTime = DispatchTime.now()
        generate(size: size)
        let endTime = DispatchTime.now()
        let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
        print("Execution time in milliseconds: \(nanoTime/1000000)")
        
    }
    
    public func generate(size: Int) -> Void {
        var searchCount = 0
        var subCount = Int()
        while(schedules.count != size){
            let posSchedg = Schedule()
            subCount = courses.count
            courses.shuffle()
            for c in courses {
                c.sections.shuffle()
                for s in c.sections {
                    
                    /* IF ONLINE COURSE */
                    /*if (s.numDays() == 0){
                        posSchedg.add(s: s)
                        if (s.getSubSecs().count == 0) {
                            continue
                        }
                        subCount -= 1
                        s.subSec = s.getSubSecs().shuffled()
                        let ss = s.getSubSecs()[Int(arc4random_uniform(UInt32(s.getSubSecs().count)))]
                        switch (periods.count) {
                        case 2:
                            if (commitConflicts(s: ss) && ss.getTimes()[0]?.period() == periods[0] || ss.getTimes()[0]?.period() == periods[1]){
                                if (!posSchedg.add(s: ss)) {
                                    posSchedg.getSections().remove(atIndex: posSchedg.getSections().count - 1)
                                }
                            }
                            break
                        case 1:
                            if (!commitConflicts(s: ss) && ss.getTimes()[0]?.period() == periods[1]) {
                                if (!posSchedg.add(s: ss)) {
                                    posSchedg.getSections().remove(atIndex: posSchedg.getSections().count - 1)
                                }
                            }
                            break
                        default:
                            if (!commitConflicts(s: ss)) {
                                if (!posSchedg.add(s: ss)) {
                                    posSchedg.getSections().remove(atIndex: posSchedg.getSections().count - 1)
                                }
                            }
                            break
                        }
                        if (posSchedg.contains(s: s)) {
                            break
                        }
                    }*/
                    
                    /* ELSE */
                    switch (periods.count) {
                    case 2:
                        if (!commitConflicts(s: s) && s.getTimes()[0]?.period() == periods[0] || s.getTimes()[0]?.period() == periods[1]) {
                            if (posSchedg.add(s: s)) {
                                if (s.getSubSecs().count == 0) {
                                    continue
                                }
                                subCount -= 1;
                                s.subSec = s.getSubSecs().shuffled()
                                let ss = s.getSubSecs()[Int(arc4random_uniform(UInt32(s.getSubSecs().count)))]
                                if (!commitConflicts(s: ss) && ss.getTimes()[0]?.period() == periods[0] || ss.getTimes()[0]?.period() == periods[1]) {
                                    if (!posSchedg.add(s: ss)) {
                                        posSchedg.getSections().remove(atIndex: posSchedg.getSections().count - 1)
                                    }
                                }
                            }
                        }
                        break
                    case 1:
                        if (!commitConflicts(s: s) && s.getTimes()[0]?.period() == periods[0]) {
                            if (posSchedg.add(s: s)) {
                                if (s.getSubSecs().count == 0) {
                                    continue
                                }
                                subCount -= 1;
                                s.subSec = s.getSubSecs().shuffled()
                                let ss = s.getSubSecs()[Int(arc4random_uniform(UInt32(s.getSubSecs().count)))]
                                if (!commitConflicts(s: ss) && ss.getTimes()[0]?.period() == periods[0]) {
                                    if (!posSchedg.add(s: ss)) {
                                        posSchedg.getSections().remove(atIndex: posSchedg.getSections().count - 1)
                                    }
                                }
                            }
                        }
                        break
                    default:
                        if (!commitConflicts(s: s)) {
                            if (posSchedg.add(s: s)) {
                                if (s.getSubSecs().count == 0) {
                                    continue
                                }
                                subCount -= 1;
                                s.subSec = s.getSubSecs().shuffled()
                                let ss = s.getSubSecs()[Int(arc4random_uniform(UInt32(s.getSubSecs().count)))]
                                if (!commitConflicts(s: ss)) {
                                    if (!posSchedg.add(s: ss)) {
                                        posSchedg.getSections().remove(atIndex: posSchedg.getSections().count - 1)
                                    }
                                }
                            }
                        }
                        break
                    }
                    if (posSchedg.contains(s: s)) {
                        break
                    }
                    
                }
            }
            if (posSchedg.getSize() == ((courses.count*2) - subCount)){
                if schedules.count == 0{
                    schedules.append(value: posSchedg)
                } else if schedules.count > 0 {
                    var amountNotEqualTo = 0
                    for index in 0...schedules.count - 1{
                        if schedules.valueAt(index: index) != posSchedg {
                            amountNotEqualTo += 1
                            if amountNotEqualTo >= schedules.count {
                                schedules.append(value: posSchedg)
                            }
                        }
                    }
                }
            }
            
            if (searchCount>=size*10) {
                //schedules.sort(MyComparator)
                break
            } else {
                searchCount += 1
                
            }
            
        }

        
    }
    
    /** TO STRING
     *	Function:	string formatted representation of this ScheduleGenerator
     *	@params	n/a
     **/
    public func toString() -> String {
        var s = "\nINPUTTED COURSES: \n"
        for ind in 0...courses.count - 1 {
            s += "\(courses[ind].toString()) \n"
        }
        
        s += "\nINPUTTED COMMITMENTS: \n"
        if commits.count > 0 {
            for inde in 0...commits.count - 1 {
                s += "\(commits[inde].toString()) \n"
            }
        }
    
        s += "\nPOSSIBLE SCHEDULES: \n"
        print("SCHEDULE COUNT: \(schedules.count)")
        if schedules.count == 0 {
            return "No possible schedules for your courses and preferences."
        } else {
            for index in 0...schedules.count-1{
                s += "OPTION: \(schedules.valueAt(index: index).toString()) \n"
            }
            return s
        }
    }
    
    /** COMMITMENT CONFILCTS
     *	Function:	checks to see if a given section conflicts with a commitment, returns true if conflict and false if no conflict
     *	@params	s = Section object that will be compared with commitment
     *	@return boolean indicating if given Section s conflicts with a commitment in commits
     **/
    public func commitConflicts(s: Section) -> Bool {
        
        for commitment in commits {
            if ((s.conflicts(s: commitment.getTimes())) || commitment.getTimes().conflicts(s: s)) {
                return true
            }
        }
        return false
    }
    
    
}

//Cite: https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift/24029847#24029847

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
         c
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
