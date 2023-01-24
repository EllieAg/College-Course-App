//
//  CourseAnimationViewController.swift
//  MyCoursesApp
//
//  Created by Elena Agina on 11/23/22.


import UIKit

class CourseAnimationViewController: UIViewController {
    
    // add picture and sizing
    let imageView: UIImageView = {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        
        imageView.image = UIImage(named: "MDClogo")
        
        return imageView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(imageView)

    } // end viewDidLoad
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: { self.animate()
            
        })
        
    } // end viewWillLayoutSubviews
    
    // add picture = animation
    func animate() {

        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 1
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size

            self.imageView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
            
        })

    } // end animate
    
} // end class CourseAnimationViewController
