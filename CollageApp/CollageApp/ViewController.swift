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
    
    // Method for check if the session can load object (here it's an UIImage)
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }

}

