//
//  ViewController.swift
//  CollageApp
//
//  Created by Christophe Bugnon on 31/01/2018.
//  Copyright © 2018 Christophe Bugnon. All rights reserved.
//

import UIKit

// Add UIDropInteractionDelegate for delegate on the method addInteraction
class ViewController: UIViewController, UIDropInteractionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the method at view for drop an image and delegate it in the view
        view.addInteraction(UIDropInteraction(delegate: self))
    }
    
    // Method for had an array of item drop in the view
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        // Loop for session.items because it's an array
        for dragItem in session.items {
            // Closure for check if obj drag is good or if it's an error
            dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (obj, err) in
                // Condition if drag is an error (other than an UIimage)
                if let err = err {
                    print("Failed to our drag item:", err)
                    return
                }
                // Condition if drag is an UIimage
                guard let draggedImage = obj as? UIImage else { return }
                
                // DispatchQueue manages the execution of work items. Each work item submitted to a queue is processed on a pool of threads managed by the system.
                DispatchQueue.main.async {
                    let imageView = UIImageView(image: draggedImage)
                    self.view.addSubview(imageView)
                    // Chose where be placed the image
                    imageView.frame = CGRect(x: 0, y: 0, width: draggedImage.size.width, height: draggedImage.size.height)
                    
                    // Returns the geometrical location of the user’s drag activity within the specified view.
                    let centerPoint = session.location(in: self.view)
                    imageView.center = centerPoint
                }
            })
        }
    }
    
    // Method for copy Drip in the session (.move is take an object from an other app and put it the drop)
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    // Method for check if the session can load object (here it's an UIImage)
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }

}

