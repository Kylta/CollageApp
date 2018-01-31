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

