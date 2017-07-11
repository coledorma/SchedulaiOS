//
//  Section.swift
//  SchedulaAlgorithm
//
//  Created by Cole Dorma on 2017-05-18.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import Foundation

public class Section {
    var ID = ""
    var prof = ""
    var crn = 0
    var times = [TimeSlot?]()
    var subSec = [SubSection?]()
    
    init(n: String, p: String, c: Int, term: Int, time: String, s: [SubSection]){
        var startHour = 0
        var startMinute = 0
        var endHour = 0
        var endMinute = 0
        let year = (Int)(term/100)
        let semester = term - year*100
        ID = n;
        prof = p;
        crn = c;
        subSec = s;
        times = [TimeSlot]()
        
        if (time.characters.count == 11){
            // If once a week (W 1405-1555)
            let startSH = time.index(time.startIndex, offsetBy: 2)
            let endSH = time.index(time.endIndex, offsetBy: -7)
            let rangeSH = startSH..<endSH
            startHour = Int(time.substring(with: rangeSH))!
            
            let startSM = time.index(time.startIndex, offsetBy: 4)
            let endSM = time.index(time.endIndex, offsetBy: -5)
            let rangeSM = startSM..<endSM
            startMinute = Int(time.substring(with: rangeSM))!
            
            let startEH = time.index(time.startIndex, offsetBy: 7)
            let endEH = time.index(time.endIndex, offsetBy: -2)
            let rangeEH = startEH..<endEH
            endHour = Int(time.substring(with: rangeEH))!
            
            let startEM = time.index(time.startIndex, offsetBy: 9)
            endMinute = Int(time.substring(from: startEM))!
            
            let dowStart = time.index(time.startIndex, offsetBy: 0)
            let dayOfWeek = String(time[dowStart])
            
            times.append(TimeSlot(dayOfWeek: dayOfWeek, startHour: startHour, startMinute: startMinute, endHour: endHour, endMinute: endMinute, termMonth: semester, termYear: year))
            times.append(nil)
            times.append(nil)
            
        } else if (time.characters.count == 12){
            // If twice a week (TR 1405-1555)
            let startSH = time.index(time.startIndex, offsetBy: 3)
            let endSH = time.index(time.endIndex, offsetBy: -7)
            let rangeSH = startSH..<endSH
            startHour = Int(time.substring(with: rangeSH))!
            
            let startSM = time.index(time.startIndex, offsetBy: 5)
            let endSM = time.index(time.endIndex, offsetBy: -5)
            let rangeSM = startSM..<endSM
            startMinute = Int(time.substring(with: rangeSM))!
            
            let startEH = time.index(time.startIndex, offsetBy: 8)
            let endEH = time.index(time.endIndex, offsetBy: -2)
            let rangeEH = startEH..<endEH
            endHour = Int(time.substring(with: rangeEH))!
            
            let startEM = time.index(time.startIndex, offsetBy: 10)
            endMinute = Int(time.substring(from: startEM))!
            
            let dowStart0 = time.index(time.startIndex, offsetBy: 0)
            let dayOfWeek0 = String(time[dowStart0])
            
            let dowStart1 = time.index(time.startIndex, offsetBy: 1)
            let dayOfWeek1 = String(time[dowStart1])
            
            times.append(TimeSlot(dayOfWeek: dayOfWeek0,startHour: startHour,startMinute: startMinute,endHour: endHour,endMinute: endMinute,termMonth: semester,termYear: year))
            times.append(TimeSlot(dayOfWeek: dayOfWeek1, startHour: startHour, startMinute: startMinute, endHour: endHour,endMinute: endMinute, termMonth: semester, termYear: year))
            times.append(nil)
            
        } else if (time.characters.count == 13){
            // If three times a week (MWF 1405-1555)
            let startSH = time.index(time.startIndex, offsetBy: 4)
            let endSH = time.index(time.endIndex, offsetBy: -7)
            let rangeSH = startSH..<endSH
            startHour = Int(time.substring(with: rangeSH))!
            
            let startSM = time.index(time.startIndex, offsetBy: 6)
            let endSM = time.index(time.endIndex, offsetBy: -5)
            let rangeSM = startSM..<endSM
            startMinute = Int(time.substring(with: rangeSM))!
            
            let startEH = time.index(time.startIndex, offsetBy: 9)
            let endEH = time.index(time.endIndex, offsetBy: -2)
            let rangeEH = startEH..<endEH
            endHour = Int(time.substring(with: rangeEH))!
            
            let startEM = time.index(time.startIndex, offsetBy: 11)
            endMinute = Int(time.substring(from: startEM))!
            
            let dowStart0 = time.index(time.startIndex, offsetBy: 0)
            let dayOfWeek0 = String(time[dowStart0])
            
            let dowStart1 = time.index(time.startIndex, offsetBy: 1)
            let dayOfWeek1 = String(time[dowStart1])
            
            let dowStart2 = time.index(time.startIndex, offsetBy: 2)
            let dayOfWeek2 = String(time[dowStart2])
            
            times.append(TimeSlot(dayOfWeek: dayOfWeek0,startHour: startHour,startMinute: startMinute,endHour: endHour,endMinute: endMinute,termMonth: semester,termYear: year))
            times.append(TimeSlot(dayOfWeek: dayOfWeek1,startHour: startHour,startMinute: startMinute,endHour: endHour,endMinute: endMinute,termMonth: semester,termYear: year))
            times.append(TimeSlot(dayOfWeek: dayOfWeek2,startHour: startHour,startMinute: startMinute,endHour: endHour,endMinute: endMinute,termMonth: semester,termYear: year))
        } else {
            times.append(nil)
            times.append(nil)
            times.append(nil)
        }
    }
    
    public func getID() -> String {
        return ID
    }
    public func getProf() -> String {
        return prof
    }
    public func getCrn() -> Int {
        return crn
    }
    public func getTimes() -> [TimeSlot?] {
        return times
    }
    func getSubSecs() -> [SubSection] {
        return subSec as! [SubSection]
    }
    public func numDays() -> Int {
        var count = 0
        if (times == nil) {
            return count
        }
        for t in times {
            if (t != nil){
                count += 1
            } else {
                count += 0
            }
            
        }
        return count;
    }
    
    //Using Section instead of AnyObject in param - might cause issues?
    public func equals(other: Section?) -> Bool{
        if (other == nil){
            return false
        }
        if (other! == self){
            return true
        }
        if (!(other is Section)){
            return false;
        }
        let otherSec = other
        
        let returnBool = (self.crn == otherSec?.crn)
        return returnBool
    }
    
    public func toString() -> String {
        return "\(ID) - \(crn) "
    }
    
    public func conflicts(s: Section?) -> Bool {
        if (self == nil || s == nil){
            return false
        }
        
        for t1 in times {
            if (t1 == nil){
                continue
            }
            for t2 in (s?.times)! {
                if (t2 == nil) {
                    continue
                }
                if ((t1?.conflicts(t: t2!))! || (t2?.conflicts(t: t1!))!){
                    return true
                }
            }
        }
        return false;
    }
    
    func addSubSection(subSection: SubSection) -> Void {
        subSec.append(subSection)
    }
    
}



extension Section: Equatable {}

public func ==(lhs: Section, rhs: Section) -> Bool {
    return lhs.crn == rhs.crn
}
