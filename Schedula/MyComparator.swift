//
//  MyComparator.swift
//  SchedulaAlgorithm
//
//  Created by Cole Dorma on 2017-05-23.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import Foundation

public class MyComparator {
    var MONDAY = "M"
    var TUESDAY = "T"
    var WEDNESDAY = "W"
    var THURSDAY = "R"
    var FRIDAY = "F"
    
    var min1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
    var max1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
    var min2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
    var max2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
    
    init(){}
    
    public func compare(s1: Schedule, s2: Schedule) -> Int {
        var dif1 = 0
        var dif2 = 0
        var min1Counter = 0
        var max1Counter = 0
        var min2Counter = 0
        var max2Counter = 0
        
        /**
         *	MONDAY
         **/
        // Reset values
        min1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        max1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        min2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        max2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        
        dif1 = 0
        dif2 = 0
        min1Counter = 0
        max1Counter = 0
        min2Counter = 0
        max2Counter = 0
        
        //Compute and add differences, respectively
        compute(sec: s1.getSections(), minCounter: min1Counter, maxCounter: max1Counter, dayOfWeek: MONDAY)
        
        if (min1.day != "" && max1.day != ""){
            dif1 += min1.difference(t: max1)
        }
        
        compute(sec: s2.getSections(), minCounter: min1Counter, maxCounter: max2Counter,dayOfWeek: MONDAY);
        
        if (min2.day != "" && max2.day != ""){
            dif2 += min2.difference(t: max2)
        }
        
        /**
         *	TUESDAY
         **/
        // Reset values
        min1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        max1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        min2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        max2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        
        dif1 = 0
        dif2 = 0
        min1Counter = 0
        max1Counter = 0
        min2Counter = 0
        max2Counter = 0
        
        //Compute and add differences, respectively
        compute(sec: s1.getSections(), minCounter: min1Counter, maxCounter: max1Counter, dayOfWeek: TUESDAY)
        
        if (min1.day != "" && max1.day != ""){
            dif1 += min1.difference(t: max1)
        }
        
        compute(sec: s2.getSections(), minCounter: min1Counter, maxCounter: max2Counter,dayOfWeek: TUESDAY)
        
        if (min2.day != "" && max2.day != ""){
            dif2 += min2.difference(t: max2)
        }
        
        /**
         *	WEDNESDAY
         **/
        // Reset values
        min1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        max1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        min2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        max2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        
        dif1 = 0
        dif2 = 0
        min1Counter = 0
        max1Counter = 0
        min2Counter = 0
        max2Counter = 0
        
        //Compute and add differences, respectively
        compute(sec: s1.getSections(), minCounter: min1Counter, maxCounter: max1Counter, dayOfWeek: WEDNESDAY)
        
        if (min1.day != "" && max1.day != ""){
            dif1 += min1.difference(t: max1)
        }
        
        compute(sec: s2.getSections(), minCounter: min1Counter, maxCounter: max2Counter, dayOfWeek: WEDNESDAY)
        
        if (min2.day != "" && max2.day != ""){
            dif2 += min2.difference(t: max2)
        }
        
        /**
         *	THURSDAY
         **/
        // Reset values
        min1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        max1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        min2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        max2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        
        dif1 = 0
        dif2 = 0
        min1Counter = 0
        max1Counter = 0
        min2Counter = 0
        max2Counter = 0
        
        //Compute and add differences, respectively
        compute(sec: s1.getSections(), minCounter: min1Counter, maxCounter: max1Counter, dayOfWeek: THURSDAY)
        
        if (min1.day != "" && max1.day != ""){
            dif1 += min1.difference(t: max1)
        }
        
        compute(sec: s2.getSections(), minCounter: min1Counter, maxCounter: max2Counter, dayOfWeek: THURSDAY)
        
        if (min2.day != "" && max2.day != ""){
            dif2 += min2.difference(t: max2)
        }
        
        /**
         *	FRIDAY
         **/
        // Reset values
        min1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        max1 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        min2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        max2 = TimeSlot(dayOfWeek: "", startHour: 0, startMinute: 0, endHour: 0, endMinute: 0, termMonth: 0, termYear: 0)
        
        dif1 = 0
        dif2 = 0
        min1Counter = 0
        max1Counter = 0
        min2Counter = 0
        max2Counter = 0
        
        //Compute and add differences, respectively
        compute(sec: s1.getSections(), minCounter: min1Counter, maxCounter: max1Counter, dayOfWeek: FRIDAY)
        
        if (min1.day != "" && max1.day != ""){
            dif1 += min1.difference(t: max1)
        }
        
        compute(sec: s2.getSections(), minCounter: min1Counter, maxCounter: max2Counter, dayOfWeek: FRIDAY)
        
        if (min2.day != "" && max2.day != ""){
            dif2 += min2.difference(t: max2)
        }
        
        
        // FINAL COMPARISON
        if (dif1 > dif2) {
            return 1
        } else if (dif1 < dif2) {
            return -1
        } else {
            return 0
        }
        
    }
    
    /** COMPUTE (HELPER FUNCTION)
     *	function:	Compares time spread between individual TimeSlots for two
     *				given times for a specific schedule
     *	@params:	LinkedList<Sections>,
     *
     **/
    private func compute(sec: LinkedList<Section>, minCounter: Int, maxCounter: Int, dayOfWeek: String) -> Void {
        
        var minCounter = 0
        var maxCounter = 0
        
        for index in 0...sec.count-1{
            let s = sec.valueAt(index: index)
            for t in s.getTimes() {
                
                if (t == nil) {
                    continue
                }
                
                if (t?.getDay() == dayOfWeek && minCounter == 0) {
                    min1 = t!
                    minCounter += 1
                } else if (t?.getDay() == dayOfWeek && maxCounter == 0) {
                    max1 = t!;
                    maxCounter += 1
                } else if (minCounter > 0 && (t?.getDay())! == dayOfWeek && (t?.getStartMins())! < min1.getStartMins()) {
                    min1 = t!;
                    minCounter += 1
                } else if (maxCounter > 0 && (t?.getDay())! == dayOfWeek && max1.getEndMins() < (t?.getEndMins())!) {
                    max1 = t!;
                    maxCounter += 1
                }
            }
        }
        return
    }
    
}
