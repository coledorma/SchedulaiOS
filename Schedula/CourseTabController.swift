//
//  CourseTabController.swift
//  Schedula
//
//  Created by Cole Dorma on 2017-06-01.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import UIKit

class CourseTabController: UITabBarController {
    
    var coursesWint = [Course]()
    var coursesFall = [Course]()
    var selectedCoursesFall = [Course]()
    var selectedCoursesWint = [Course]()
    var courseArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
