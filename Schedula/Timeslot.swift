//
//  TimeSlot.swift
//  SchedulaAlgorithm
//
//  Created by Cole Dorma on 2017-05-18.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import Foundation

public class TimeSlot {
    
    let MONDAY = "M"
    let TUESDAY = "T"
    let WEDNESDAY = "W"
    let THURSDAY = "R"
    let FRIDAY = "F"
    var day = ""
    let start = NSDateComponents()
    let end = NSDateComponents()
    var term = ""
    
    var description: String {
        var sm = String(start.minute)
        var em = String(end.minute)
        var eh = String(end.hour)
        var sh = String(start.hour)
        
        if start.minute < 10 {
            sm = "0" + String(start.minute)
        }
        
        if end.minute < 10 {
            em = "0" + String(end.minute)
        }
        
        if end.hour < 10 {
            eh = "0" + String(end.hour)
        }
        
        if start.hour < 10 {
            sh = "0" + String(start.hour)
        }

        return "\(sh):\(sm) - \(eh):\(em)"
    }
    
    init(dayOfWeek: String, startHour: Int, startMinute: Int, endHour: Int, endMinute: Int, termMonth: Int, termYear: Int){
        day = dayOfWeek
        var tm = 0
        var dw = 0
        var sd = 0
        
        _ = sd + 1
        
        switch dayOfWeek{
        case MONDAY:
            dw=2
            break
        case TUESDAY:
            dw=3
            break
        case WEDNESDAY:
            dw=4
            break
        case THURSDAY:
            dw=5
            break
        case FRIDAY:
            dw=6
            break
        default:
            break
        }
        
        switch termMonth {
        case 10:
            //For January
            tm = 0
            sd = 9
            term = "WINTER"
            break;
        case 20:
            //For May
            tm = 4
            sd = 1
            term = "SUMMER"
            break
        case 30:
            //For September
            tm = 8
            sd = 12
            term = "FALL"
            break
        default:
            break
        }
        
        start.hour = startHour
        start.minute = startMinute
        start.month = tm
        start.year = termYear
        //MISSING DAY OF MONTH - Do I need it?
        start.weekday = dw
        
        end.hour = endHour
        end.minute = endMinute
        end.month = tm
        end.year = termYear
        //MISSING DAY OF MONTH - Do I need it?
        end.weekday = dw
        
    }
    
    public func getDay() -> String {
        return day
    }
    public func getStart() -> NSDateComponents {
        return start;
    }
    public func getEnd() -> NSDateComponents {
        return end;
    }
    public func getStartMins() -> Int {
        return start.hour*60 + start.minute
    }
    public func getEndMins()	 -> Int {
        return end.hour*60 + end.minute
    }
    
    public func toString() -> String {
        var s = "\tTIMESLOT\nTerm:\t\t \(term) \(start.year) \nDay:\t\t"
        
        switch(start.weekday){
        case 2:
            s+="MON\n"
            break
        case 3:
            s+="TUE\n"
            break
        case 4:
            s+="WED\n"
            break
        case 5:
            s+="THU\n"
            break
        case 6:
            s+="FRI\n"
            break
        default:
            break
        }
        let sh = start.hour
        let sm = start.minute
        let eh = end.hour
        let em = end.minute
        
        //MISSING AM and PM due to 24 hour format
        s += "Start-Time:\t\(sh):\(sm)\n"
        s += "End-Time:\t\(eh):\(em)\n"
        return s
    }
    
    public func conflicts(t: TimeSlot) -> Bool {
        //Do I need this?
        /*if (self == nil || t == nil){
         return false
         }*/
        
        if (!(term == t.term)){
            return false
        }
        
        if (start.isEqual(t.start) == true || end.isEqual(t.end) == true){
            return true
        }
        
        let	startMin = start.hour*60 + start.minute
        let endMin = end.hour*60 + end.minute
        let startMinT = t.start.hour*60 + t.start.minute
        let endMinT = t.end.hour*60 + t.end.minute
        
        return	(start.weekday == t.start.weekday) &&
            ((startMinT >= startMin && startMinT <= endMin) ||
                (endMinT >= startMin && endMinT <= endMin) ||
                (startMinT <= startMin && endMinT >= endMin))
    }
    
    public func period() -> String {
        if (start.hour < 12) {
            return "Morning"
        } else if (start.hour < 17) {
            return "Afternoon"
        } else {
            return "Evening"
        }
    }
    
    public func difference(t: TimeSlot) -> Int {
        var difference = 0
        var startMinutes = 0
        var endMinutes = 0
        
        if (conflicts(t: t) == true) {
            return difference;
        } else {
            if (start.weekday == t.start.weekday) {
                if (((start.hour*60) + (start.minute)) >= ((t.end.hour*60) + (t.end.minute))) {
                    startMinutes += start.hour * 60;
                    startMinutes += start.minute
                    endMinutes += t.end.hour * 60;
                    endMinutes += t.end.minute
                } else {
                    startMinutes += t.start.hour * 60;
                    startMinutes += t.start.minute
                    endMinutes += end.hour * 60;
                    endMinutes += end.minute;
                }
                difference = startMinutes - endMinutes;
            } else {
                return -1
            }
        }
        return difference;
    }
    
    let date = NSDate()
    let calendar = NSDateComponents()
    
    
    /*let components = calendar.components([.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond], fromDate: date)
     let now = NSCalendar.currentCalendar.dateWithEra(1, year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second, nanosecond: components.nanosecond)!
     
     let start = NSCalendar()
     Calendar end;
     String term;
     
     init(){
     
     }*/
    
    
}
