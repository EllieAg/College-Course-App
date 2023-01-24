//
//
//  ItemStore.swift
//  LootLogger
//
//  Created by Elena Agina on 10/26/22.


import UIKit

class CourseStore {
    
    var allCourses = [Course]()
    
    let courseArchiveURL: URL = {
        
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("courses.plist")
        
    }() // () -> URL
    
    @discardableResult func createCourse() -> Course {
        
        let newCourse = Course(random: true)
        
        allCourses.append(newCourse)
        
        return newCourse
        
    }//end createCourse
    
    func removeCourse(_ course: Course) {
        
        if let index = allCourses.firstIndex(of: course) {
            
            allCourses.remove(at: index)
            
        }
        
    }// end removeCourse
    
    
    func moveCourse(from fromIndex: Int, to toIndex: Int) {
        
        if fromIndex == toIndex {
            return
        }
        
        // get reference to the object being moved so we can insert it
        let movedCourse = allCourses[fromIndex]
        
        allCourses.remove(at: fromIndex)
        
        // insert item in array at new location
        allCourses.insert(movedCourse, at: toIndex)
        
        
    }// end moveCourse
    
    @objc func saveChanges() throws {
        
        print("Saving items to: \(courseArchiveURL)")
        
        do {
            
            let encoder = PropertyListEncoder()
            
            let data = try encoder.encode(allCourses)
            
            try data.write(to: courseArchiveURL, options: [.atomic])
            
            print("Saved all of the items")
            
        } catch let encodingError {
            
            print("Error encoding allItems: \(encodingError)")
            
        }
        
    }// end saveChanges
    
    init() {
        
        do {
            
            let data = try Data(contentsOf: courseArchiveURL)
            
            let unachiver = PropertyListDecoder()
            
            let courses = try unachiver.decode([Course].self, from: data)
            
            allCourses = courses
            
        } catch {
            
            print("Error readind in saved items: \(error)")
            
        }
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
    
}// end class
