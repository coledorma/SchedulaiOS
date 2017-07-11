//
//  ViewController.swift
//  Schedula
//
//  Created by Cole Dorma on 2017-05-10.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {

    @IBOutlet var NextButton: UIButton!
    
    @IBOutlet var circleButton: UIButton!
    
    @IBOutlet var schedUnderText: UILabel!
    
    @IBOutlet var schedulaLogo: UIImageView!
    
    @IBOutlet var schedText: UILabel!
    
    //XML Parser cite: www.theappguruz.com/blog/xml-parsing-using-nsxmlparse-swift#sthash.e9x2d0Jv.dpuf
    var parser = XMLParser()
    var element = String()
    var sectionData = [String]()
    var coursesWint = [Course]()
    var coursesFall = [Course]()
    var currentElement : String?
    
    var lineCount = 0
    var dead = 0
    
    let backgroundQueue = DispatchQueue(label: "com.app.queue",
                                        qos: .background,
                                        target: nil)
    
    @IBOutlet var simpleProgress: UIProgressView!
    var timer: Timer?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundQueue.async {
            print("Started")
            let startTime = DispatchTime.now()
            self.beginParsing()
            let endTime = DispatchTime.now()
            let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
            print("Total parsing time: \(nanoTime/1000000000) seconds")
            DispatchQueue.main.async {
            }
        }
        
        schedText.text = ""
        schedUnderText.text = ""
        NextButton.isHidden = true
        NextButton.layer.cornerRadius = 4
        circleButton.isHidden = true
        schedulaLogo.isHidden = true
        circleButton.layer.cornerRadius = 127.5
        self.simpleProgress?.progress = 0.0
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateProgress), userInfo: nil, repeats: true)
        
    }
    
    func updateProgress() {
        self.simpleProgress?.progress += 0.01
        print("Prog: \(simpleProgress?.progress)")
        if simpleProgress?.progress == 1.0 {
            print("DONE")
            self.simpleProgress?.removeFromSuperview()
            timer?.invalidate()
            schedText.text = "Schedula"
            schedUnderText.text = "Your painless and powerful course scheduling application."
            NextButton.isHidden = false
            circleButton.isHidden = false
            schedulaLogo.isHidden = false
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func NextButtonClicked(_ sender: UIButton) {
        print("clicked")
        performSegue(withIdentifier: "passCoursesFallWint", sender: sender)
    }
    
    func beginParsing(){
        parser = XMLParser(contentsOf:(NSURL(string:"https://raw.githubusercontent.com/EvanCooper9/Schedula/master/courses.xml?token=ASkrwAM-lCWdXxVgo_CjFC4ogVTqwfmNks5ZSmndwA%3D%3D"))! as URL)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
    
        element = elementName
        if elementName == "Row" {
            sectionData.removeAll()
        }
        
        if elementName == "Cell" {
            
        }
        
        if elementName == "Data" {
            currentElement = ""
        } else {
            currentElement = nil
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element == "Cell" {
                sectionData.append("")
        }
        
        if element == "Data" {
            if currentElement != nil {
                currentElement? += string
            }
            lineCount += 1
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Data" {
            //To account for <Cell  />
            if let name = currentElement {
                if name != "\n    " && name != "\n   " {
                    sectionData.append(name)
                }
            }
            
        }
        currentElement = nil
        
        if elementName == "Row"{
            if (sectionData[4].characters.count > 1) {
                let subSection = SubSection(s: sectionData[2] + "\n" + sectionData[3] + sectionData[4], t: sectionData[5], c: Int(sectionData[1])!, tr: Int(sectionData[0])!, time: sectionData[7]);
                
                if (sectionData[0] == "201710") {
                    if let i = coursesWint.index(where: { $0.code == sectionData[2] + sectionData[3] }) {
                        let course = coursesWint[i]
                        for section in course.sections {
                            let subString = self.sectionData[4]
                            let index = subString.index(subString.startIndex, offsetBy: 2)
                            let subID = subString.substring(to: index)
                            //if (section.getID().equals(sectionData.get(4).substring(0, 2))) {
                            if section.getID() == subID {
                                section.addSubSection(subSection: subSection)
                                break
                            }
                        }
                    } else {
                        // deal with the parents not being created
                        dead += 1
                    }
                } else {
                    if let i = coursesFall.index(where: { $0.code == sectionData[2] + sectionData[3] }) {
                        let course = coursesFall[i]
                        for section in course.sections {
                            let subString1 = section.getID()
                            let index1 = subString1.index(subString1.startIndex, offsetBy: 9)
                            let subID1 = subString1.substring(from: index1)
                            
                            let subString2 = self.sectionData[4]
                            let index2 = subString2.index(subString2.startIndex, offsetBy: 1)
                            let subID2 = subString2.substring(to: index2)
                            
                            if subID1 == subID2 {
                            //if (section.getID().substring(9).equals(sectionData.get(4).substring(0, 1))) {
                                section.addSubSection(subSection: subSection)
                                break
                            }
                        }
                    } else {
                        // deal with the parents not being created
                        dead += 1
                    }
                }
            } else {
                let section = Section(n: sectionData[2] + "\n" + sectionData[3] + sectionData[4], p: sectionData[6], c: Int(sectionData[1])!, term: Int(sectionData[0])!, time: sectionData[7], s: [SubSection]())
                
                /*
                 * Verify if a Course exists for this Section, do as necessary.
                 * Add the Section to it's parent Course.
                 */
                if (sectionData[0] == "201710") {
                    if let i = coursesWint.index(where: { $0.code == sectionData[2] + sectionData[3] }) {
                        let course = coursesWint[i]
                        course.sections.append(section)
                    } else {
                        let course = Course(cod: sectionData[2] + sectionData[3], sec: [Section]());
                        course.sections.append(section)
                        coursesWint.append(course)
                    }
                } else {
                    if let i = coursesFall.index(where: { $0.code == sectionData[2] + sectionData[3] }) {
                        let course = coursesFall[i]
                        course.sections.append(section)
                    } else {
                        let course = Course(cod: sectionData[2] + sectionData[3], sec: [Section]())
                        course.sections.append(section)
                        coursesFall.append(course)
                    }
                }
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let CourseView = segue.destination as? CourseTabController
        CourseView?.coursesFall = coursesFall
        CourseView?.coursesWint = coursesWint
    }


}

