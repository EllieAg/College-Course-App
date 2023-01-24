//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Elena Agina on 10/26/22.


import UIKit

class CourseViewController: UITableViewController {
    
    var courseStore: CourseStore! = CourseStore()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return courseStore.allCourses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseManager
        
        // Set the text on the cell with the description of the item that is at the
        let course = courseStore.allCourses[indexPath.row]
        
        cell.courseLabel.text = course.course
        
        cell.gradeLabel.text = course.grade
        
        return cell
        
    }// end tableView:cellForRowAt
    
    @IBAction func addNewCourse(_ sender: UIBarButtonItem) {
        
        // create a new item and add it to the store
        let newCourse = courseStore.createCourse()
        
        // figure out where that item is in the array
        if let index = courseStore.allCourses.firstIndex(of: newCourse) {
            
            let indexPath = IndexPath(row: index, section: 0)
            
            // insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }//end addNewItem
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        // if the table view is asking to delete
        if editingStyle == .delete {
            
            let course = courseStore.allCourses[indexPath.row]
            
            // Remove the item from the store
            courseStore.removeCourse(course)
            
            // Remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }// end tableView:commit:forRowAt
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // update model
        courseStore.moveCourse(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }// end tableView:moveRowAt:to
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedRowHeight = 65
        
    }// end viewDidLoad
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // if the triggered segue is the "showItem" segue
        switch segue.identifier {
            
        case "showCourse":
            // figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // get the item associated with this row and pass it along
                let course = courseStore.allCourses[row]
                
                let detailViewController = segue.destination as! CourseDetailViewController
                
                detailViewController.course = course
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }//end prepare:for:sender
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }//end viewWillAppear
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }//end init
    
}//end class
