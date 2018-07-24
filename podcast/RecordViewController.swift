//
//  RecordViewController.swift
//  podcast
//
//  Created by David Faliskie on 7/23/18.
//  Copyright © 2018 David Faliskie. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var statuslabel: UILabel!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioFileURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRecorderSession()
        
        // view related config
        uploadButton.isHidden = true
        statuslabel.textColor = UIColor.lightGray
        
    }
    
    // handel finish recording, a flag means the recording was inturrpted
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if !flag {
//            finishRecording(success: false)
//        }
//    }

    // This function wil configure the AVAudio Recorder, get recorde permission from user
    func configureRecorderSession() {
        do {
            recordingSession = AVAudioSession.sharedInstance()
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        // failed to record!
                        print("User denied Permission to recorde")
                        self.statuslabel.text = "Allow Audio Recording Access in settings to continue."
                    }
                }
            }
        } catch {
            // failed to record!
            print("AVAudioSession configureRecorder() failed...")
        }
    }
    
    
    // this function will load the recording UI after a user has given permission.
    func loadRecordingUI() {
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        view.addSubview(recordButton)
    }
    
    // Function to determine where to save the audio, configure the recording settings, and start recording
    func startRecording() {
        audioFileURL = getDocumentsDirectory().appendingPathComponent("recording_.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            uploadButton.isHidden = true
            recordButton.setTitle("Tap to Stop", for: .normal)
            self.statuslabel.text = "Recording..."
        } catch {
            finishRecording(success: false)
        }
        
    }
    
    // Function to finish recording, will reset the button
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
            uploadButton.isHidden = false
            self.statuslabel.text = "Cool, Audio recorded successfully"
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
            self.statuslabel.text = "Oh No! That didn't work, try again."
        }
    }
    
    // call start or stop recording depending on the state of the audio recorder
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    
    // helpers
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "uploadRecording" {
            guard let destinationController = segue.destination as? UploadAudioViewController else {return}
            // convert the file to string and remove the file://
            let audioFileString = "\(self.audioFileURL)"
            let audioFileFormatted = audioFileString.replacingOccurrences(of: "file://", with: "")
            print("AUDIO FILE FORMATTED: \(audioFileFormatted)")
            destinationController.audioFileURL = "\(self.audioFileURL)"
        }
    }
    
}



