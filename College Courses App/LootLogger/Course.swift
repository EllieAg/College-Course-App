//
//  Item.swift
//  LootLogger
//
//  Created by Elena Agina on 10/26/22.


import UIKit

class Course: Equatable, Codable {
    
    
    var course: String
    var grade: String
    var instructorName: String
    var semester: String
    var year: Int
    
    let dateCreated: Date
    
    init(course: String, grade: String, instructorName: String, semester: String, year: Int) {
        self.course = course
        self.grade = grade
        self.instructorName = instructorName
        self.semester = semester
        self.year = year
        
        self.dateCreated = Date()
    }//end init
    
    convenience init(random: Bool = false) {
        if random {
            let letter = ["COP", "CGS", "PHI"]
            let number = ["1060", "2660", "1200"]
            let grade = ["A", "B", "C", "D", "F"]
            
            let randomLetter = letter.randomElement()!
            let randomNumber = number.randomElement()!
            let randomGrade = grade.randomElement()!
            
            let randomCourse = "\(randomLetter) \(randomNumber)"
            
            self.init(course: randomCourse, grade: randomGrade, instructorName: "Anna Hernandez", semester: "Spring", year: 2022)
            
        } else {
            self.init(course: "", grade: "", instructorName: "", semester: "", year: 0)
        }
        
    }//end convience init
    
    // attribute1 == attribute2
    static func ==(lhs: Course, rhs: Course) -> Bool {
        return lhs.course == rhs.course
            && lhs.grade == rhs.grade
            && lhs.instructorName == rhs.instructorName
            && lhs.semester == rhs.semester
            && lhs.year == rhs.year
            && lhs.dateCreated == rhs.dateCreated
    }
    
}// end class


    


