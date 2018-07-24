//
//  UploadAudioViewController.swift
//  podcast
//
//  Created by David Faliskie on 7/16/18.
//  Copyright © 2018 David Faliskie. All rights reserved.
//

import Firebase

class UploadAudioViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    
    // audioFileURL which can be passed from the RecordViewController
    var audioFileURL: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTF.delegate = self
        descriptionTV.delegate = self
        
        // add border to description text view (make this a function?)
        descriptionTV!.layer.borderWidth = 1
        descriptionTV!.layer.cornerRadius = 5
        descriptionTV!.layer.borderColor = UIColor.lightGray.cgColor
        
        titleTF!.layer.borderWidth = 1
        titleTF!.layer.cornerRadius = 5
        titleTF!.layer.borderColor = UIColor.lightGray.cgColor
        
        
        //Default checking and disabling of the Button
        if (titleTF.text?.isEmpty)!{
            uploadBtn.isEnabled = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // What happens when the upload button is pressed
    @IBAction func uploadBtn(_ sender: Any) {
        uploadFromFile()
    }
    
    // Disable the upload button until some text is entered
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Find out what the text field will be after adding the current edit
        let titleText = (titleTF.text! as NSString).replacingCharacters(in: range, with: string)
        
        //Checking if the input field is empty
        if titleText.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty{
            // Disable Save Button
            uploadBtn.isEnabled = false
        } else {
            // Enable Save Button
            uploadBtn.isEnabled = true
        }
        return true
    }
    
    func uploadFromFile() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // Local file you want to upload
        let localFile = URL(fileURLWithPath: audioFileURL)
        
        // Create a reference to the file you want to upload, this gives the name meta data.
        let castRef = storageRef.child("podcasts/Dave/\(titleTF.text!)")
        
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.customMetadata = [
            "UserName" : "Dave (Update to user name)",
            "Description" : self.descriptionTV.text,
            "DeviceType" : "\(UIDevice.current.model)",
            "DeviceOS" : "\(UIDevice.current.systemVersion)"
        ]
        
        
        // Upload file and metadata to the object 'images/mountains.jpg'
        let uploadTask = castRef.putFile(from: localFile, metadata: metadata)
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            self.statusLabel.text = String(percentComplete)
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            self.successLabel.text = "\(self.titleTF.text!) Successfully Uploaded!"
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
        
    }
    
    

    
}
