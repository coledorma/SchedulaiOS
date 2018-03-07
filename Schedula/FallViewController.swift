//
//  FallViewController.swift
//  Schedula
//
//  Created by Cole Dorma on 2017-05-10.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import UIKit

class FallViewController: UITableViewController {
    
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var courseText: UITextField!
    var courseArray = [String]()
    var courseCode = ""
    var fullCourseCode = ""
    var coursesFall = [Course]()
    var fullCoursesFall = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tbvc = self.tabBarController  as! CourseTabController
        self.coursesFall = tbvc.coursesFall
        if tbvc.selectedCoursesFall.count > 0 {
            self.courseArray = tbvc.courseArray
        }
        self.fullCoursesFall = tbvc.selectedCoursesFall
        
        doneButton.layer.cornerRadius = 4
        addButton.layer.cornerRadius = 4
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
        fullCoursesFall.remove(at: indexPath.row)

        self.tableView.reloadData()
    }
  
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        courseText.text = courseText.text?.uppercased()
        let splitString = courseText.text?.components(separatedBy: " ")
        courseCode = (splitString?[0])!
        if (splitString?.count)! >= 2 {
            fullCourseCode = (splitString?[0])! + (splitString?[1])!
        }
        
        if (splitString!.count == 2 && splitString![0].characters.count == 4 && splitString![1].characters.count == 4){
            print("Course entered: \(courseText.text!.uppercased())")
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
            
            if alreadyAdded == false{
                if let i = coursesFall.index(where: { $0.code == fullCourseCode }) {
                    
                    let course = coursesFall[i]
                    fullCoursesFall.append(course)
                
                    if (courseArray.count > 6){
                        courseArray.remove(at: 6)
                        fullCoursesFall.remove(at: 6)
                        let alert = UIAlertController(title: "Oops!", message: "You've hit your 6 course limit. Tap on a course to remove one.", preferredStyle: UIAlertControllerStyle.alert)
                        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                        alert.addAction(alertAction)
                        present(alert, animated: true)
                    }
                } else {
                    courseArray.remove(at: courseArray.count - 1)
                    let alert = UIAlertController(title: "ERROR", message: "This course doesn't exist for this semester. Check the course code and try again.", preferredStyle: UIAlertControllerStyle.alert)
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
        print("Full Courses: \(fullCoursesFall)")
        self.tableView.reloadData()
        courseText.text = ""
        
    }

    @IBAction func doneButtonClicked(_ sender: UIButton) {
        if fullCoursesFall.count < 1 {
            let alert = UIAlertController(title: "ERROR", message: "You MUST add at least one course.", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            alert.addAction(alertAction)
            present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "passCourseArrayFall", sender: sender)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let SecondView = segue.destination as? SecondViewController
            SecondView?.secCourseArray = courseArray
            SecondView?.fullCoursesFall = fullCoursesFall
            SecondView?.coursesFall = coursesFall
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
