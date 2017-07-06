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
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addupdatebutton: UIButton!
    @IBOutlet weak var jerseyImageView: UIImageView!
    @IBOutlet weak var clubNameTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    var  jersey : Jersey? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        imagePicker.delegate = self
        
        if jersey != nil {
         jerseyImageView.image = UIImage(data: jersey!.image! as Data)
            clubNameTextField.text = jersey!.title
            
            addupdatebutton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
        
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
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func addTapped(_ sender: Any) {
        // There is game updates
        
        if jersey != nil {
            jersey!.title = clubNameTextField.text
            jersey!.image = UIImagePNGRepresentation(jerseyImageView.image!) as NSData?

            
        }else{
            //no game so New game and saves
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let jersey = Jersey(context: context)
            jersey.title = clubNameTextField.text
            jersey.image = UIImagePNGRepresentation(jerseyImageView.image!) as NSData?
            
        }
        // saves
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        

    }
      // deletes and saves deletion
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(jersey!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)

        
    }

    
}
