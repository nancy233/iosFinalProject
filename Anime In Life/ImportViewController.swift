//
//  ImportViewController.swift
//  Anime In Life
//
//  Created by nancy on 5/2/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import CoreLocation

class ImportViewController:UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var tableCells:String?
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var importButton: UIButton!
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
            // after it is complete
        }
    }
    
    let username = FIRAuth.auth()?.currentUser?.displayName
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            // do something with the image
            let dbRef = FIRDatabase.database().reference()
            let storageRef = FIRStorage.storage().reference().child(username!+tableCells!)
            if let uploadData = UIImagePNGRepresentation(image){
                storageRef.put(uploadData, metadata: nil, completion: {(metadata, error) in
                    if error != nil{
                        print(error)
                        return
                    }else{
                        let urlString = metadata?.downloadURL()?.absoluteString
                        let value:[String:AnyObject] = ["username":self.username as AnyObject,
                                                        "message":self.message.text as AnyObject,
                                                        "image":urlString as AnyObject]
                        dbRef.child("User").childByAutoId().setValue(value)
                        print("upload success")
                        let url = URL(string: urlString!)
                        let imageData = NSData(contentsOf:url!)
                        let image = UIImage(data: imageData as! Data)
                        self.importButton.setImage(image, for: .normal)
                    }
                })
            }
        }else{
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "import.png") as UIImage!
        importButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        importButton.setImage(image, for: .normal)
        importButton.contentMode = .center
        importButton.imageView?.contentMode = .scaleAspectFit
        
        message.contentMode = .center
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
