//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Elena Agina on 10/26/22.


import UIKit

class CourseDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var courseField: UITextField!
    
    @IBOutlet var gradeField: UITextField!
    
    @IBOutlet var instructorNameField: UITextField!
    
    @IBOutlet var semesterField: UITextField!
    
    @IBOutlet var yearField: UITextField!
    
    @IBOutlet var dateField: UILabel!
   
    
    var course: Course! {
        didSet {
            navigationItem.title = course.course
        }
    }
    
    // Date generator in mm/dd/yyyy style
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none

        return formatter
    }()
    
    // No decimals allowed
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.numberStyle = .none
      
        return formatter
    }()


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        courseField.text = course.course
        gradeField.text = "\(course.grade)"
        instructorNameField.text = course.instructorName
        semesterField.text = course.semester
        yearField.text = "\(course.year)"
        
        dateField.text = dateFormatter.string(from: course.dateCreated)

    }//end viewWillAppear
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // clear first responder
        view.endEditing(true)
       
        // save changes to course
        course.course = courseField.text ?? ""
        course.grade = gradeField.text ?? ""
        course.instructorName = instructorNameField.text!
        course.semester = semesterField.text ?? ""
  
        if let valueText = yearField.text,
           
           let value = numberFormatter.number(from: valueText) {
            
               course.year = value.intValue
            
        } else {
            course.year = 0
        }
    } //end viewWillDisappear
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }//end textFieldShouldReturn
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }//end backgroundTapped

}//end class
