//
//  SecondViewController.swift
//  Schedula
//
//  Created by Cole Dorma on 2017-05-10.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var generateButton: UIButton!
    
    @IBOutlet var addButton: UIButton!
    
    @IBOutlet var backButton: UIButton!
    
    var secCourseArray: [String]!
    var specificTimes: [String] = []
    var specificDays: [String] = []
    var wholeDays: [String] = []
    var preferredDay = [String]()
    var pickerData = ["Morning", "Afternoon", "Night"]
    var commitments = [Commitment]()
    var commitmentsWholeDays = [Commitment]()
    var commitmentsSpecificTimes = [Commitment]()
    @IBOutlet var preferredDayPicker: UIPickerView!

    var timeData = [["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14" , "15" , "16" , "17" , "18" , "19" , "20" , "21" , "22" , "23" , "24"], ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14" , "15" , "16" , "17" , "18" , "19" , "20" , "21" , "22" , "23" , "24" , "25" , "26" , "27" , "28" , "29" , "30" , "31" , "32", "33" , "34" , "35" , "36" , "37" , "38" , "39" , "40" , "41" , "42" , "43" , "44" , "45" , "46" , "47" , "48" , "49" , "50" , "51" , "52" , "53" , "54" , "55" , "56" , "57" , "58" , "59"], ["Mon", "Tue", "Wed", "Thu", "Fri"]]
    
    @IBOutlet var begTime: UITextField!
    @IBOutlet var endTime: UITextField!
    var begDone = false
    var endDone = false
    
    @IBOutlet var mondaySwitch: UISwitch!
    @IBOutlet var tuesdaySwitch: UISwitch!
    @IBOutlet var wednesdaySwitch: UISwitch!
    @IBOutlet var thursdaySwitch: UISwitch!
    @IBOutlet var fridaySwitch: UISwitch!
    
    var specMon = false
    var specTue = false
    var specWed = false
    var specThu = false
    var specFri = false
    
    var fullCoursesFall = [Course]()
    var fullCoursesWint = [Course]()
    
    var coursesFall = [Course]()
    var coursesWint = [Course]()
    
    var schedulesLinked = LinkedList<Schedule>()
    
    @IBOutlet var tableView: UITableView!
    let cellID = "cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SECOND: ")
        print(secCourseArray)
        
        preferredDayPicker.dataSource = self
        preferredDayPicker.delegate = self
        preferredDayPicker.selectRow(1, inComponent: 0, animated: false)
        
        let preferredTimePicker = UIPickerView()
        preferredTimePicker.delegate = self
        preferredTimePicker.selectRow(12, inComponent: 0, animated: false)
        preferredTimePicker.selectRow(30, inComponent: 1, animated: false)
        preferredTimePicker.selectRow(2, inComponent: 2, animated: false)
        
        mondaySwitch.setOn(false, animated: false)
        tuesdaySwitch.setOn(false, animated: false)
        wednesdaySwitch.setOn(false, animated: false)
        thursdaySwitch.setOn(false, animated: false)
        fridaySwitch.setOn(false, animated: false)
        
        begTime.inputView = preferredTimePicker
        endTime.inputView = preferredTimePicker
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addButton.layer.cornerRadius = 4
        generateButton.layer.cornerRadius = 4
        backButton.layer.cornerRadius = 4

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func generateButtonClicked(_ sender: Any) {
        print("Selected Courses: \(secCourseArray)")
        print("Specific TOD: \(preferredDay)")
        print("Specific Days: \(wholeDays)")
        print("Specific Times: \(specificTimes)")
        
        if fullCoursesFall.count > 0 {
            if wholeDays.count > 0 {
                for i in 0...wholeDays.count - 1{
                    commitmentsWholeDays.append(Commitment(typ: "", ter: 201630, tim: "\(wholeDays[i]) 0001-2359"))
                }
            }
            
            commitments = commitmentsSpecificTimes + commitmentsWholeDays
            
            print("Courses: \(fullCoursesFall)")
            for index in 0...fullCoursesFall.count - 1{
                print("Course Sections: \(fullCoursesFall[index].sections.count)")
                for ind in 0...fullCoursesFall[index].sections.count - 1{
                    print("Course Sections crn: \(fullCoursesFall[index].sections[ind].getCrn())")
                    print("Course Sections crn: \(fullCoursesFall[index].sections[ind].times)")
                    print("Course SubSections: \(fullCoursesFall[index].sections[ind].getSubSecs())")
                    for i in 0...fullCoursesFall[index].sections[ind].times.count - 1{
                        print("index: \(index), ind: \(ind), i: \(i)")
                        print("Course subsection time START: \(String(describing: fullCoursesFall[index].sections[ind].times[i]?.getStart()))")
                        print("Course subsection time END: \(String(describing: fullCoursesFall[index].sections[ind].times[i]?.getEnd()))")

                    }
                }
            }

            let schedules = ScheduleGenerator(cr: fullCoursesFall, cm: commitments, p: preferredDay, size: 10, prefOnline: false)
            schedulesLinked = schedules.schedules
            if schedulesLinked.count < 1 {
                let alert = UIAlertController(title: "ERROR", message: "No possible schedules based on your courses and preferences. Please remove/change some of your preferences and/or courses and try again.", preferredStyle: UIAlertControllerStyle.alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                alert.addAction(alertAction)
                present(alert, animated: true)
                commitmentsWholeDays.removeAll()
                
            }
            
        } else {
            if wholeDays.count > 0 {
                for i in 0...wholeDays.count - 1{
                    commitmentsWholeDays.append(Commitment(typ: "", ter: 201710, tim: "\(wholeDays[i]) 0001-2359"))
                }
            }
            commitments = commitmentsSpecificTimes + commitmentsWholeDays
  
            print("Courses: \(fullCoursesWint)")
            
            let schedules = ScheduleGenerator(cr: fullCoursesWint, cm: commitments, p: preferredDay, size: 10, prefOnline: false)
            schedulesLinked = schedules.schedules
            if schedulesLinked.count < 1 {
                let alert = UIAlertController(title: "ERROR", message: "No possible schedules based on your courses and preferences. Please remove/change some of your preferences and/or courses and try again.", preferredStyle: UIAlertControllerStyle.alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                alert.addAction(alertAction)
                present(alert, animated: true)
                commitmentsWholeDays.removeAll()
            }

        }
        
        if schedulesLinked.count > 0 {
            performSegue(withIdentifier: "passPrefsAndCourses", sender: sender)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let CalendarView = segue.destination as? CalendarCollectionViewController
        CalendarView?.courseArray = secCourseArray
        CalendarView?.schedulesLinked = schedulesLinked
        
        let CourseTab = segue.destination as? CourseTabController
        CourseTab?.coursesFall = coursesFall
        CourseTab?.coursesWint = coursesWint
        CourseTab?.courseArray = secCourseArray
        CourseTab?.selectedCoursesFall = fullCoursesFall
        CourseTab?.selectedCoursesWint = fullCoursesWint

    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 5 {
            return 1
        } else {
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 5 {
            return pickerData.count
        } else {
            return timeData[component].count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 5 && row < 3 {
            return pickerData[row]
        } else {
            if component == 0 {
                return String(timeData[0][row])
            } else if component == 1 {
                return String(timeData[1][row])
            } else {
                return String(timeData[2][row])
            }
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 5 {
            if (row == 0){
                preferredDay.append("Morning")
                //preferredDay.remove(at: 0)
            } else if (row == 1){
                preferredDay.append("Afternoon")
                //preferredDay.remove(at: 0)
            } else if (row == 2){
                preferredDay.append("Night")
                //preferredDay.remove(at: 0)
            }
            print("Preferred day: \(preferredDay)")
        } else {
            if endDone == false && begDone == true {
                let hour = timeData[0][pickerView.selectedRow(inComponent: 0)]
                let minute = timeData[1][pickerView.selectedRow(inComponent: 1)]
                let day = timeData[2][pickerView.selectedRow(inComponent: 2)]
                begTime.text = hour + "" + minute + " " + day
            } else if endDone == true && begDone == true {
                let hour = timeData[0][pickerView.selectedRow(inComponent: 0)]
                let minute = timeData[1][pickerView.selectedRow(inComponent: 1)]
                let day = timeData[2][pickerView.selectedRow(inComponent: 2)]
                endTime.text = hour + "" + minute + " " + day
            }
        }
        
    }
    @IBAction func begTextClicked(_ sender: Any) {
        begDone = true
    }
    
    @IBAction func endTextClicked(_ sender: Any) {
        endDone = true
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        if begTime.text != "" && endTime.text != "" {
            let splitStringBeg = self.begTime.text?.components(separatedBy: " ")
            let splitStringEnd = self.endTime.text?.components(separatedBy: " ")
            let begTimeHour = splitStringBeg?[0]
            let endTimeHour = splitStringEnd?[0]
            let begTimeDay = splitStringBeg?[1]
            if fullCoursesFall.count > 0 {
                if begTimeDay == "Mon" {
                    commitmentsSpecificTimes.append(Commitment(typ: "", ter: 201630, tim: "M "+begTimeHour!+"-"+endTimeHour!))
                } else if begTimeDay == "Tue" {
                    commitmentsSpecificTimes.append(Commitment(typ: "", ter: 201630, tim: "T "+begTimeHour!+"-"+endTimeHour!))
                } else if begTimeDay == "Wed" {
                    commitmentsSpecificTimes.append(Commitment(typ: "", ter: 201630, tim: "W "+begTimeHour!+"-"+endTimeHour!))
                } else if begTimeDay == "Thu" {
                    commitmentsSpecificTimes.append(Commitment(typ: "", ter: 201630, tim: "R "+begTimeHour!+"-"+endTimeHour!))
                } else if begTimeDay == "Fri" {
                    commitmentsSpecificTimes.append(Commitment(typ: "", ter: 201630, tim: "F "+begTimeHour!+"-"+endTimeHour!))
                }
            } else {
                if begTimeDay == "Mon" {
                    commitmentsSpecificTimes.append(Commitment(typ: "", ter: 201710, tim: "M "+begTimeHour!+"-"+endTimeHour!))
                } else if begTimeDay == "Tue" {
                    commitmentsSpecificTimes.append(Commitment(typ: "", ter: 201710, tim: "T "+begTimeHour!+"-"+endTimeHour!))
                } else if begTimeDay == "Wed" {
                    commitmentsSpecificTimes.append(Commitment(typ: "", ter: 201710, tim: "W "+begTimeHour!+"-"+endTimeHour!))
                } else if begTimeDay == "Thu" {
                    commitmentsSpecificTimes.append(Commitment(typ: "", ter: 201710, tim: "R "+begTimeHour!+"-"+endTimeHour!))
                } else if begTimeDay == "Fri" {
                    commitmentsSpecificTimes.append(Commitment(typ: "", ter: 201710, tim: "F "+begTimeHour!+"-"+endTimeHour!))
                }
            }
            
            let totalTime = begTime.text! + " to " + endTime.text!
            specificTimes.append(totalTime)
            begTime.text = ""
            endTime.text = ""
            begTime.resignFirstResponder()
            endTime.resignFirstResponder()
            endDone = false
            begDone = false
            print(specificTimes)
            tableView.reloadData()
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specificTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellID) as UITableViewCell!
        
        cell.textLabel?.text = specificTimes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        specificTimes.remove(at: indexPath.row)
        commitmentsSpecificTimes.remove(at: indexPath.row)
        print(specificTimes)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            specificTimes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

    }
    
    @IBAction func mondayTouched(_ sender: Any) {
        specMon = !specMon
        if specMon == true {
            wholeDays.append("M")
        } else {
            wholeDays = wholeDays.filter{$0 != "M"}
        }
        print(wholeDays)
    }
    @IBAction func tuesdayTouched(_ sender: Any) {
        specTue = !specTue
        if specTue == true {
            wholeDays.append("T")
        } else {
            wholeDays = wholeDays.filter{$0 != "T"}
        }
        print(wholeDays)
    }
    @IBAction func wednesdayTouched(_ sender: Any) {
        specWed = !specWed
        if specWed == true {
            wholeDays.append("W")
        } else {
            wholeDays = wholeDays.filter{$0 != "W"}
        }
        print(wholeDays)
    }
    @IBAction func thursdayTouched(_ sender: Any) {
        specThu = !specThu
        if specThu == true {
            wholeDays.append("R")
        } else {
            wholeDays = wholeDays.filter{$0 != "R"}
        }
        print(wholeDays)
    }
    @IBAction func fridayTouched(_ sender: Any) {
        specFri = !specFri
        if specFri == true {
            wholeDays.append("F")
        } else {
            wholeDays = wholeDays.filter{$0 != "F"}
        }
        print(wholeDays)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
            performSegue(withIdentifier: "backToCourses", sender: sender)
        
    }

}
