//
//  JerseyViewController.swift
//  JerseyCollector
//
//  Created by user on 7/5/17.
//  Copyright © 2017 Appster. All rights reserved.
//

import UIKit

class JerseyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Oulets
    
    @IBOutlet weak var jerseyImageView: UIImageView!
    @IBOutlet weak var clubNameTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        imagePicker.delegate = self
        
    }

   // Actions Tapped
    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        jerseyImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let jersey = Jersey(context: context)
        jersey.title = clubNameTextField.text
        jersey.image = UIImagePNGRepresentation(jerseyImageView.image!) as NSData?
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        

    }


    
}
