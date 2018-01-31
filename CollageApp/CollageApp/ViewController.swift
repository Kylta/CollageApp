//
//  ViewController.swift
//  CollageApp
//
//  Created by Christophe Bugnon on 31/01/2018.
//  Copyright © 2018 Christophe Bugnon. All rights reserved.
//

import UIKit

// The interface for configuring and controlling a drop interaction.
// The interface for configuring and controlling a drag interaction.
class ViewController: UIViewController, UIDropInteractionDelegate, UIDragInteractionDelegate {
    
    // Asks the delegate for the array of drag items for an impending drag interaction.
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        // Returns the geometrical location of the user’s drag activity within the specified view.
        let touchedPoint = session.location(in: self.view)
        // Returns the farthest descendant of the receiver in the view hierarchy (including itself) that contains a specified point.
        if let touchedImageView = self.view.hitTest(touchedPoint, with: nil) as? UIImageView {
            
            let touchedImage = touchedImageView.image
            
            // An item provider for conveying data or a file between processes during drag and drop or copy/paste activities, or from a host app to an app extension.
            let itemProvider = NSItemProvider(object: touchedImage!)
            // A representation of an underlying data item being dragged from one location to another.
            let dragItem = UIDragItem(itemProvider: itemProvider)
            
            return [dragItem]
        }
        
        return []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // An interaction to enable dropping of items onto a view, employing a delegate to instantiate objects and respond to calls from the drop session.
        view.addInteraction(UIDropInteraction(delegate: self))
        // An interaction to enable dragging of items from a view, employing a delegate to provide drag items and to respond to calls from the drag session.
        view.addInteraction(UIDragInteraction(delegate: self))
    }
    
    // Tells the delegate it can request the item provider data from the session’s drag items.
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        // An array of drag items in the drag session or drop session.
        for dragItem in session.items {
            // Asynchronously loads an object of a specified class to an item provider, returning a Progress object.
            dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (obj, err) in
                
                if let err = err {
                    print("Failed to our drag item:", err)
                    return
                }
                
                guard let draggedImage = obj as? UIImage else { return }
                
                // DispatchQueue manages the execution of work items. Each work item submitted to a queue is processed on a pool of threads managed by the system.
                DispatchQueue.main.async {
                    let imageView = UIImageView(image: draggedImage)
                    // A Boolean value that determines whether user events are ignored and removed from the event queue.
                    imageView.isUserInteractionEnabled = true
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
    
    // Tells the delegate the drop session has changed.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    // Asks the delegate whether it can handle the session’s drag items.
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }

}

