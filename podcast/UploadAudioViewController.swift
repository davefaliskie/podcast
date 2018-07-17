//
//  UploadAudioViewController.swift
//  podcast
//
//  Created by David Faliskie on 7/16/18.
//  Copyright © 2018 David Faliskie. All rights reserved.
//

import Firebase

class UploadAudioViewController: UIViewController {
    
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func uploadBtn(_ sender: Any) {
        uploadFromFile()
    }
    
//    func uploadFromFile() {
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//
//        // File located on disk
//        let localFile = URL(fileURLWithPath: "/Users/DaveFaliskie/Desktop/test55.m4a")
//
//        // Create a reference to the file you want to upload
//        let castRef = storageRef.child("podcasts/test55.m4a")
//
//        // Upload the file to the path "podcasts/test55.m4a"
//        let uploadTask = castRef.putFile(from: localFile, metadata: nil) { metadata, error in
//
//        }
//    }
    
    
    func uploadFromFile() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // Local file you want to upload
        let localFile = URL(fileURLWithPath: "/Users/DaveFaliskie/Desktop/15minepisode.mp3")
        
        // Create a reference to the file you want to upload
        let castRef = storageRef.child("podcasts/15minepisode.mp3")
        
        // Create the file metadata
        let metadata = StorageMetadata()
//        metadata.contentType = "podcast/audio"
        metadata.customMetadata = [
            "UserName" : "Dave",
            "Description" : "Here is a sample of an actual podcast - 15 minutes in length. Let's see how long this upload      takes and what kind of storage it takes up."
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
            self.successLabel.text = "Your file was Successfully Uploaded!"
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
