//
//  SchedulaTests.swift
//  SchedulaTests
//
//  Created by Cole Dorma on 2017-05-10.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import XCTest
@testable import Schedula

class SchedulaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlgorithmSpeed1() {
        var startTimer = DispatchTime.now()

        var commitments = [Commitment]()
        var courses = [Course]();
        var subsections1 = [SubSection]();
        var subsections2 = [SubSection]();
        var subsections3 = [SubSection]();
        var subsections4 = [SubSection]();
        var subsections5 = [SubSection]();
        var subsections6 = [SubSection]();
        var sections1 = [Section]();
        var sections2 = [Section]();
        var sections3 = [Section]();
        var sections4 = [Section]();
        
        var periods = [String]()
        
        commitments.append(Commitment(typ: "LAX",ter: 201630,tim: "F 0605-0610"))
        
        subsections1.append(SubSection(s: "A1",t: "TUT",c: 111111,tr: 201630,time: "F 1405-1555"));
        subsections1.append(SubSection(s: "A2",t: "TUT",c: 211112,tr: 201630,time: "W 1605-1755"));
        subsections2.append(SubSection(s: "B1",t: "TUT",c: 311113,tr: 201630,time: "F 0835-0955"));
        subsections2.append(SubSection(s: "B2",t: "TUT",c: 411114,tr: 201630,time: "W 1605-1755"));
        subsections3.append(SubSection(s: "A1",t: "TUT",c: 522221,tr: 201630,time: "M 1305-1355"));
        subsections3.append(SubSection(s: "A2",t: "TUT",c: 622222,tr: 201630,time: "M 1605-1755"));
        subsections4.append(SubSection(s: "A1",t: "TUT",c: 733331,tr: 201630,time: "F 1405-1555"))
        subsections4.append(SubSection(s: "A2",t: "TUT",c: 833332,tr: 201630,time: "W 1605-1755"))
        subsections5.append(SubSection(s: "B1",t: "TUT",c: 933333,tr: 201630,time: "F 1405-1555"))
        subsections5.append(SubSection(s: "B2",t: "TUT",c: 033334,tr: 201630,time: "W 1605-1755"))
        subsections6.append(SubSection(s: "A1",t: "TUT",c: 100001,tr: 201630,time: "F 0835-0955"))
        subsections6.append(SubSection(s: "A2",t: "TUT",c: 100002,tr: 201630,time: "W 1605-1755"))
        
        
        
        sections1.append(Section(n: "A", p: "Bobby", c: 111110,term: 201630,time: "MW 1005-1125",s: subsections1));
        sections2.append(Section(n: "A", p: "Timmy", c: 111100,term: 201630,time: "TR 1305-1425",s: subsections2));
        sections2.append(Section(n: "A", p: "John", c: 222220,term: 201630,time: "MW 1005-1125",s: subsections3));
        sections3.append(Section(n: "A", p: "Hannah", c: 333330,term: 201630,time: "TR 0835-0955",s: subsections4));
        sections3.append(Section(n: "B", p: "Samuel", c: 333300,term: 201630,time: "TR 1135-1255",s: subsections5));
        sections4.append(Section(n: "V", p: "Mike", c: 111000,term: 201630,time: "",s: subsections6));
        
        courses.append(Course(cod: "COMP3004", sec: sections1));
        courses.append(Course(cod: "COMP3005", sec: sections2));
        courses.append(Course(cod: "COMP500", sec: sections3));
        courses.append(Course(cod: "COMP666", sec: sections4));
        
        periods.append("Morning");
        periods.append("Afternoon");
        
        var schedgs = ScheduleGenerator(cr: courses, cm: commitments, p: periods, size: 10, prefOnline: true);
        
        /**
         *    RESULTS
         **/
        let stopTimer = DispatchTime.now()
        let nanoTime = stopTimer.uptimeNanoseconds - startTimer.uptimeNanoseconds
        let totalTime = (nanoTime/1000000)
        print("Execution time: \(totalTime) milliseconds")
        
    }
    
    func testAlgorithmSpeed2() {
        var startTimer = DispatchTime.now()
        
        var commitments = [Commitment]()
        var courses = [Course]();
        var subsections1 = [SubSection]();
        var subsections2 = [SubSection]();
        var subsections3 = [SubSection]();
        var subsections4 = [SubSection]();
        var subsections5 = [SubSection]();
        var subsections6 = [SubSection]();
        var sections1 = [Section]();
        var sections2 = [Section]();
        var sections3 = [Section]();
        
        var periods = [String]()
        
        commitments.append(Commitment(typ: "LAX",ter: 201630,tim: "F 0605-0610"))
        
        sections1.append(Section(n: "A", p: "", c: 111110,term: 201630,time: "TR 1305-1425",s: subsections1));
        sections2.append(Section(n: "A", p: "", c: 222220,term: 201630,time: "MW 1005-1125",s: subsections2));
        sections2.append(Section(n: "A", p: "", c: 333330,term: 201630,time: "TR 0835-0955",s: subsections3));
        
        courses.append(Course(cod: "COMP3004", sec: sections1));
        courses.append(Course(cod: "COMP3005", sec: sections2));
        courses.append(Course(cod: "COMP3007", sec: sections3));
        
        periods.append("Morning");
        periods.append("Afternoon");
        
        var schedgs = ScheduleGenerator(cr: courses, cm: commitments, p: periods, size: 10, prefOnline: true);
        
        /**
         *    RESULTS
         **/
        var stopTimer = DispatchTime.now()
        let nanoTime = stopTimer.uptimeNanoseconds - startTimer.uptimeNanoseconds
        let totalTime = (nanoTime/1000000)
        print("Execution time: \(totalTime) milliseconds")
        
    }
    
    func testAlgorithmValidity() {
        var startTimer = DispatchTime.now()
        
        var commitments = [Commitment]()
        var courses = [Course]();
        var subsections1 = [SubSection]();
        var subsections2 = [SubSection]();
        var subsections3 = [SubSection]();
        var subsections4 = [SubSection]();
        var subsections5 = [SubSection]();
        var subsections6 = [SubSection]();
        var sections1 = [Section]();
        var sections2 = [Section]();
        var sections3 = [Section]();
        
        var periods = [String]()
        
        commitments.append(Commitment(typ: "LAX",ter: 201630,tim: "F 0605-0610"))
        
        sections1.append(Section(n: "A", p: "", c: 111110,term: 201630,time: "TR 1305-1425",s: subsections1));
        sections2.append(Section(n: "A", p: "", c: 222220,term: 201630,time: "MW 1005-1125",s: subsections2));
        sections2.append(Section(n: "A", p: "", c: 333330,term: 201630,time: "TR 0835-0955",s: subsections3));
        
        courses.append(Course(cod: "COMP3004", sec: sections1));
        courses.append(Course(cod: "COMP3005", sec: sections2));
        courses.append(Course(cod: "COMP3007", sec: sections3));
        
        periods.append("Morning");
        periods.append("Afternoon");
        
        var schedgs = ScheduleGenerator(cr: courses, cm: commitments, p: periods, size: 10, prefOnline: true);
        
        /**
         *    RESULTS
         **/
        var stopTimer = DispatchTime.now()
        let nanoTime = stopTimer.uptimeNanoseconds - startTimer.uptimeNanoseconds
        let totalTime = (nanoTime/1000000)
        print("Execution time: \(totalTime) milliseconds")
        
        XCTAssertEqual(schedgs.schedules.count, 1, "The schedules were generated properly!")
        
    }
    
    
    
}
