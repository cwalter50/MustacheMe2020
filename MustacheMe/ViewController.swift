//
//  ViewController.swift
//  MustacheMe
//
//  Created by Christopher Walter on 11/3/17.
//  Copyright © 2017 AssistStat. All rights reserved.
//

import UIKit

// Added UIImagePickerController Delegate to access camers
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    // create global variable for UIImagePicker
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set imagePickers delegate to self
        picker.delegate = self
    }
    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer)
    {
        // ToDo: What do we want to have happen after we tap an image?
        
        let location = sender.location(in: myImageView)
        
        let frame = CGRect(x: location.x, y: location.y, width: 90, height: 60)
        let newMustache = UIImageView(frame: frame)
        newMustache.image = UIImage(named: "Mustache")
        newMustache.center = location
        newMustache.tag = 34
        myImageView.addSubview(newMustache)
        
        // programmitically make pan gesture
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(mustachePanned(_:)))
        newMustache.addGestureRecognizer(pan)
        newMustache.isUserInteractionEnabled = true
        
    }
    
    @objc func mustachePanned(_ sender: UIPanGestureRecognizer)
    {
        let mustache = sender.view
        mustache?.center = sender.location(in: myImageView)
    }

    @IBAction func cameraButtonSelected(_ sender: UIBarButtonItem) {
        

        // To Do
        
        cameraAlert()
    }
    
    func cameraAlert() {
        let alert = UIAlertController(title: "Select where to get image from", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let libraryAction = UIAlertAction(title: "PHOTO LIBRARY", style: UIAlertActionStyle.default) { (action) in
            // To Do
            self.picker.sourceType = .photoLibrary
            // set up any other features of the camera that you want...
            
            self.present(self.picker, animated: true, completion: nil)
            
            
        }
        let cameraAction = UIAlertAction(title: "CAMERA", style: UIAlertActionStyle.default) { (action) in
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil
            {
                //To Do
            }
            else{
                self.noCamera()
            }
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel)
        {(action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(libraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clearButtonSelected(_ sender: UIBarButtonItem) {
        
        for subview in myImageView.subviews
        {
            if subview.tag == 34
            {
                subview.removeFromSuperview()
            }
        }
        
    }
    
    func noCamera() {
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    // To Do :  Add ImagePicker Methods
    
    // Make sure you add privacy warnings on info.plist
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        if let myImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            myImageView.image = myImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}

