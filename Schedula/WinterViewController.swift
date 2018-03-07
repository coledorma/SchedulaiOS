//
//  WinterViewController.swift
//  Schedula
//
//  Created by Cole Dorma on 2017-05-11.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import UIKit

class WinterViewController: UITableViewController {
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var courseText: UITextField!
    var courseArray = [String]()
    var coursesWint = [Course]()
    var courseCode = ""
    var fullCourseCode = ""
    var fullCoursesWint = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tbvc = self.tabBarController  as! CourseTabController
        self.coursesWint = tbvc.coursesWint
        if tbvc.selectedCoursesWint.count > 0 {
            self.courseArray = tbvc.courseArray
        }
        fullCoursesWint = tbvc.selectedCoursesWint
        
        addButton.layer.cornerRadius = 4
        doneButton.layer.cornerRadius = 4
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    //For populating the tableview's cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = courseArray[indexPath.row]
        
        return cell
    }
    
    //For selecting a certain cell in the tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        courseArray.remove(at: indexPath.row)
        fullCoursesWint.remove(at: indexPath.row)
        self.tableView.reloadData()
    }

    @IBAction func addButtonClicked(_ sender: UIButton) {
        let splitString = courseText.text?.components(separatedBy: " ")
        courseCode = (splitString?[0])!
        if (splitString?.count)! >= 2 {
            fullCourseCode = (splitString?[0])! + (splitString?[1])!
        }
        
        if (splitString!.count == 2 && splitString![0].characters.count == 4 && splitString![1].characters.count == 4){
            print("Course entered: \(courseText.text!)")
            var alreadyAdded = false
            
            if courseArray.count > 0 {
                if let i = courseArray.index(where: { $0 == courseText.text! }) {
                    let alert = UIAlertController(title: "Oops!", message: "You've already added this course.", preferredStyle: UIAlertControllerStyle.alert)
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                    alert.addAction(alertAction)
                    present(alert, animated: true)
                    courseArray.remove(at: i)
                    alreadyAdded = true
                }
            }
            
            courseArray.append(courseText.text!)
            
            if alreadyAdded == false {
                if let i = coursesWint.index(where: { $0.code == fullCourseCode }) {
                    let course = coursesWint[i]
                    fullCoursesWint.append(course)
                    
                    if (courseArray.count > 6){
                        courseArray.remove(at: 6)
                        fullCoursesWint.remove(at: 6)
                        let alert = UIAlertController(title: "Oops!", message: "You've hit your 6 course limit. Tap on a specific course to remove one.", preferredStyle: UIAlertControllerStyle.alert)
                        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                        alert.addAction(alertAction)
                        present(alert, animated: true)
                    }
                } else {
                    courseArray.remove(at: courseArray.count - 1)
                    let alert = UIAlertController(title: "ERROR", message: "This course doesn't exist. Check the course code and try again.", preferredStyle: UIAlertControllerStyle.alert)
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                    alert.addAction(alertAction)
                    present(alert, animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "ERROR", message: "Incorrect format entered. The format should be LLLL 0000. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
        
        if fullCoursesWint.count > 0 {
            for indexy in 0...fullCoursesWint.count - 1 {
                print("Full courses wint #\(indexy): \(fullCoursesWint[indexy].toString())")
            }
        }

        self.tableView.reloadData()
        courseText.text = ""
    }

    @IBAction func doneButtonClicked(_ sender: Any) {
        if fullCoursesWint.count < 1 {
            let alert = UIAlertController(title: "ERROR", message: "You MUST add at least one course.", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            alert.addAction(alertAction)
            present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "passCourseArrayWinter", sender: sender)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let SecondView = segue.destination as? SecondViewController
        SecondView?.secCourseArray = courseArray
        SecondView?.fullCoursesWint = fullCoursesWint
        SecondView?.coursesWint = coursesWint
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
