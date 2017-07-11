//
//  CalendarCollectionViewController.swift
//  Schedula
//
//  Created by Cole Dorma on 2017-05-17.
//  Copyright © 2017 Cole Dorma. All rights reserved.
//

import UIKit


class CalendarCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,  UITableViewDelegate, UITableViewDataSource {
    
    let reuseIdentifier = "DayCell"
    let optionReuseIdentifier = "OpCell"
    
    @IBOutlet var tableView: UITableView!
    let cellID = "cell"
    
    var courseArray = [String]()
    var schedulesLinked = LinkedList<Schedule>()
    
    @IBOutlet var courseInfoButton: UIButton!
    
    var letterArray = ["A","B","C", "D", "E", "F", "G", "H", "I", "J"]
    var scheduleSelected = "A"
    var optionArray = [String]()
    var onlineArray = [[String]]()
    var monArray = [[String]]()
    var tueArray = [[String]]()
    var wedArray = [[String]]()
    var thuArray = [[String]]()
    var friArray = [[String]]()
    
    var scheduleIndex = 0

    @IBOutlet var dayLabel: UILabel!
    
    var days = ["M", "T", "W", "T", "F"]
    
    override func viewWillAppear(_ animated: Bool) {
        //collectionView!.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Cal courses: \(courseArray)")
        for i in 0...schedulesLinked.count - 1 {
            print("ID 1: \(schedulesLinked.valueAt(index: i).sections[0].ID)")
            
            print("Schedules count: \(schedulesLinked.count)")
        }
        
        for i in 0...schedulesLinked.count - 1{
            optionArray.append(letterArray[i])
        }
        
        dayLabel.text = "Monday"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        updateTableView(i: scheduleIndex)
        
        courseInfoButton.layer.cornerRadius = 4
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 3 {
            return optionArray.count
        } else {
            return days.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: optionReuseIdentifier, for: indexPath as IndexPath) as! OptionCollectionViewCell
            cell.optionLabel.text = self.optionArray[indexPath.item]
            cell.backgroundColor = UIColor.white
            cell.layer.cornerRadius = 17
            
            if indexPath.row == 0 {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
                cell.backgroundColor = UIColor.red
                cell.optionLabel.textColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor.white
                cell.optionLabel.textColor = UIColor.black
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
            cell.label.text = self.days[indexPath.item]
            cell.backgroundColor = UIColor(red: 0.941176, green: 0.941176, blue: 0.941176, alpha: 1.0)
            cell.layer.cornerRadius = 25
            
            if indexPath.row == 0 {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
                cell.backgroundColor = UIColor.red
                cell.label.textColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor(red: 0.941176, green: 0.941176, blue: 0.941176, alpha: 1.0)
                cell.label.textColor = UIColor.black
            }
            
            return cell
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 3 {
            let cell = collectionView.cellForItem(at: indexPath) as! OptionCollectionViewCell
            cell.backgroundColor = UIColor.red
            cell.optionLabel.textColor = UIColor.white
            scheduleSelected = optionArray[indexPath.row]
            print("Schedule selected: \(scheduleSelected)")
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.backgroundColor = UIColor.red
            cell.label.textColor = UIColor.white
            
            if indexPath.item == 0 {
                dayLabel.text = "Monday"
            } else if indexPath.item == 1 {
                dayLabel.text = "Tuesday"
            } else if indexPath.item == 2 {
                dayLabel.text = "Wednesday"
            } else if indexPath.item == 3 {
                dayLabel.text = "Thursday"
            } else if indexPath.item == 4 {
                dayLabel.text = "Friday"
            }
        }
        
        onlineArray.removeAll()
        monArray.removeAll()
        tueArray.removeAll()
        wedArray.removeAll()
        thuArray.removeAll()
        friArray.removeAll()
        
        scheduleIndex = Int(optionArray.index(of: scheduleSelected)!)
        
        updateTableView(i: scheduleIndex)
        
        tableView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 3 {
            let cell = collectionView.cellForItem(at: indexPath) as! OptionCollectionViewCell
            cell.backgroundColor = UIColor.white
            cell.optionLabel.textColor = UIColor.black
            
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.backgroundColor = UIColor(red: 0.941176, green: 0.941176, blue: 0.941176, alpha: 1.0)
            cell.label.textColor = UIColor.black
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dayLabel.text == "Monday" {
            return monArray.count
        } else if dayLabel.text == "Tuesday" {
            return tueArray.count
        } else if dayLabel.text == "Wednesday" {
            return wedArray.count
        } else if dayLabel.text == "Thursday" {
            return thuArray.count
        } else {
            return friArray.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as UITableViewCell!
        cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        if dayLabel.text == "Monday" {
            monArray.sort {
                $0[1] < $1[1]
            }
            
            cell?.textLabel?.text = monArray[indexPath.row][0]
            cell?.detailTextLabel?.text = monArray[indexPath.row][1]
        } else if dayLabel.text == "Tuesday" {
            tueArray.sort {
                $0[1] < $1[1]
            }
            
            cell?.textLabel?.text = tueArray[indexPath.row][0]
            cell?.detailTextLabel?.text = tueArray[indexPath.row][1]
        } else if dayLabel.text == "Wednesday" {
            wedArray.sort {
                $0[1] < $1[1]
            }
            
            cell?.textLabel?.text = wedArray[indexPath.row][0]
            cell?.detailTextLabel?.text = wedArray[indexPath.row][1]
        } else if dayLabel.text == "Thursday" {
            thuArray.sort {
                $0[1] < $1[1]
            }
            
            cell?.textLabel?.text = thuArray[indexPath.row][0]
            cell?.detailTextLabel?.text = thuArray[indexPath.row][1]
        } else {
            friArray.sort {
                $0[1] < $1[1]
            }
            
            cell?.textLabel?.text = friArray[indexPath.row][0]
            cell?.detailTextLabel?.text = friArray[indexPath.row][1]
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //courseArray.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            courseArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    func updateTableView(i: Int) {
        var temp = [String]()
        
        for j in 0...schedulesLinked.valueAt(index: i).sections.count - 1 {
            print("what are these times[1] looking like? \(String(describing: schedulesLinked.valueAt(index: i).sections[j].times[1]?.day))")
            if schedulesLinked.valueAt(index: i).sections[j].ID.characters.count > 1 && schedulesLinked.valueAt(index: i).sections[j].times[0]?.day == nil && schedulesLinked.valueAt(index: i).sections[j].times[1]?.day == nil{
                var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                
                temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                temp.append("ONLINE")
                
                if onlineArray.contains(where: { $0 == temp } ) == false {
                    onlineArray.append(temp)
                }
                temp.removeAll()
                print("LEC Online Array: \(onlineArray)")
            } else if schedulesLinked.valueAt(index: i).sections[j].ID.characters.count == 10 {
                for k in 0...1 {
                    print("Index of k = \(k)")
                    print("HELLLLLLLLLLLL \(schedulesLinked.valueAt(index: i).sections[j].times[k]!.day)")
                    if schedulesLinked.valueAt(index: i).sections[j].times[k]!.day == "M" {
                        var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                        
                        temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                        temp.append(schedulesLinked.valueAt(index: i).sections[j].times[k]!.description)
                        
                        if monArray.contains(where: { $0 == temp } ) == false {
                            monArray.append(temp)
                        }
                        temp.removeAll()
                        print("LEC Monday Array: \(monArray)")
                        
                    } else if schedulesLinked.valueAt(index: i).sections[j].times[k]!.day == "T" {
                        var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                        
                        temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                        temp.append(schedulesLinked.valueAt(index: i).sections[j].times[k]!.description)
                        
                        if tueArray.contains(where: { $0 == temp } ) == false {
                            tueArray.append(temp)
                        }
                        temp.removeAll()
                        print("LEC Tuesday Array: \(tueArray)")
                        
                    } else if schedulesLinked.valueAt(index: i).sections[j].times[k]!.day == "W" {
                        var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                        
                        temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                        temp.append(schedulesLinked.valueAt(index: i).sections[j].times[k]!.description)
                        
                        if wedArray.contains(where: { $0 == temp } ) == false {
                            wedArray.append(temp)
                        }
                        temp.removeAll()
                        print("LEC Wed Array: \(wedArray)")
                        
                    }  else if schedulesLinked.valueAt(index: i).sections[j].times[k]!.day == "R" {
                        var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                        
                        temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                        temp.append(schedulesLinked.valueAt(index: i).sections[j].times[k]!.description)
                        
                        if thuArray.contains(where: { $0 == temp } ) == false {
                            thuArray.append(temp)
                        }
                        temp.removeAll()
                        print("LEC Thu Array: \(thuArray)")
                        
                    } else if schedulesLinked.valueAt(index: i).sections[j].times[k]!.day == "F" {
                        var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                        
                        temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                        temp.append(schedulesLinked.valueAt(index: i).sections[j].times[k]!.description)
                        
                        if friArray.contains(where: { $0 == temp } ) == false {
                            friArray.append(temp)
                        }
                        temp.removeAll()
                        print("LEC Fri Array: \(friArray)")
                        
                    }
                }
                //TUTORIAL
            } else {
                
                if schedulesLinked.valueAt(index: i).sections[j].times[0]!.day == "M" {
                    var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                    
                    temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                    temp.append(schedulesLinked.valueAt(index: i).sections[j].times[0]!.description)
                    
                    if monArray.contains(where: { $0 == temp } ) == false {
                        monArray.append(temp)
                    }
                    temp.removeAll()
                    print("Monday Array: \(monArray)")
                    
                } else if schedulesLinked.valueAt(index: i).sections[j].times[0]!.day == "T" {
                    var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                    
                    temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                    temp.append(schedulesLinked.valueAt(index: i).sections[j].times[0]!.description)
                    
                    if tueArray.contains(where: { $0 == temp } ) == false {
                        tueArray.append(temp)
                    }
                    temp.removeAll()
                    print("Tuesday Array: \(tueArray)")
                    
                } else if schedulesLinked.valueAt(index: i).sections[j].times[0]!.day == "W" {
                    var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                    
                    temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                    temp.append(schedulesLinked.valueAt(index: i).sections[j].times[0]!.description)
                    
                    if wedArray.contains(where: { $0 == temp } ) == false {
                        wedArray.append(temp)
                    }
                    temp.removeAll()
                    print("Wed Array: \(wedArray)")
                    
                }  else if schedulesLinked.valueAt(index: i).sections[j].times[0]!.day == "R" {
                    var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                    
                    temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                    temp.append(schedulesLinked.valueAt(index: i).sections[j].times[0]!.description)
                    
                    if thuArray.contains(where: { $0 == temp } ) == false {
                        thuArray.append(temp)
                    }
                    temp.removeAll()
                    print("Thu Array: \(thuArray)")
                    
                } else if schedulesLinked.valueAt(index: i).sections[j].times[0]!.day == "F" {
                    var tempID = schedulesLinked.valueAt(index: i).sections[j].ID
                    
                    temp.append(String(tempID.characters.filter { !"\n".characters.contains($0) }))
                    temp.append(schedulesLinked.valueAt(index: i).sections[j].times[0]!.description)
                    
                    if friArray.contains(where: { $0 == temp } ) == false {
                        friArray.append(temp)
                    }
                    temp.removeAll()
                    print("Fri Array: \(friArray)")
                    
                }
                
            }
        }
        
        tableView.reloadData()

    }
    
    @IBAction func courseInfoButtonClicked(_ sender: Any) {
        var courseInfo = ""
        for i in 0...schedulesLinked.valueAt(index: scheduleIndex).sections.count - 1{
            courseInfo += String(schedulesLinked.valueAt(index: scheduleIndex).sections[i].toString().characters.filter { !"\n".characters.contains($0) }) + "\n"
        }
        
        let alert = UIAlertController(title: "Course Information", message: "\(courseInfo)", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alert.addAction(alertAction)
        present(alert, animated: true)

    }
    
 
}
