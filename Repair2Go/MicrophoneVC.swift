//
//  MicrophoneVC.swift
//  Repair2Go
//
//  Created by mobile on 12/24/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import AVFoundation

class MicrophoneVC: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var lblMicrophone: UILabel!    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    var isAudioRecordingGranted: Bool!
    var isPlaying = false
    
    var currentInputDataSourceMode: inputDataSourceMode?
    var micMode: Int?
    enum inputDataSourceMode: String {
        case
        top = "Top",
        back = "Back",
        front = "Front"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        micMode = 0
        currentInputDataSourceMode = inputDataSourceMode.top
        lblMicrophone.text = "Top"
        
        checkRecordPermissions()
        self.recordButton.addTarget(self, action: #selector(self.onTappedBtnRecord), for: .touchUpInside)
        
    }
    
    func checkRecordPermissions() {
        
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSession.RecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSession.RecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                DispatchQueue.main.async {
                    if allowed {
                        self.isAudioRecordingGranted = true
                    } else {
                        self.isAudioRecordingGranted = false
                    }
                }
                
            })
            break
        default:
            break
        }
        
    }
    
    func setupInputDataSoure(strDataSourceName: String){
        
        guard let inputs = AVAudioSession.sharedInstance().availableInputs else{
            return
        }
        print(inputs.debugDescription)
        
        for input in inputs{
            print(input.dataSources ?? "??")
        }
        
        // set preferred:
        let preferredPort = inputs[0]
        if let dataSources = preferredPort.dataSources{
            for source in dataSources {
                if source.dataSourceName == strDataSourceName {
                    do {
                        try preferredPort.setPreferredDataSource(source)
                    }catch _ {
                        print("cannot set frontDataSource")
                    }
                }
            }
        }
    }
    
    @objc func onTappedBtnRecord (_ sender: Any) {
        if isAudioRecordingGranted {
            
            setupInputDataSoure(strDataSourceName: currentInputDataSourceMode!.rawValue)
            recordingSession = AVAudioSession.sharedInstance()
            
            do {
                try recordingSession.setCategory(.playAndRecord, mode: .default)
                try recordingSession.setActive(true)
                
            } catch {
                print("Failed to record!")
            }
            
            if audioRecorder == nil {
                startRecording()
                playButton.isEnabled = false
            } else {
                finishRecording(success: true)
                playButton.isEnabled = true
            }
        } else {
            displayAlert(alertTitle: "", msg: "You don't have access to your microphone.", actionTitle: "OK")
        }
        
    }
    
    func startRecording() {
        let audioFileUrl = getFileUrl()
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileUrl, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            recordButton.setTitle("Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getFileUrl() -> URL {
        let path = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        return path
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordButton.setTitle("Record", for: .normal)
        } else {
            recordButton.setTitle("Record", for: .normal)
            print("Recording failed")
        }
    }
    
    
    @IBAction func onTappedBtnChangeMicrophone(_ sender: Any) {
        micMode = micMode! + 1
        if micMode == 3 {
            micMode = 0
        }
        if micMode == 0 {
            currentInputDataSourceMode = inputDataSourceMode.top
            lblMicrophone.text = "Top"
        } else if micMode == 1 {
            currentInputDataSourceMode = inputDataSourceMode.back
            lblMicrophone.text = "Back"
        } else {
            currentInputDataSourceMode = inputDataSourceMode.front
            lblMicrophone.text = "Front"
        }
        
    }
    
    func prepare_play() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
            audioPlayer.volume = 2.0
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error")
        }
    }
    
    @IBAction func onTappedBtnPlay(_ sender: Any) {
        if(isPlaying) {
            audioPlayer.stop()
            recordButton.isEnabled = true
            playButton.setTitle("Play", for: .normal)
            isPlaying = false
        } else {
            if FileManager.default.fileExists(atPath: getFileUrl().path) {
                recordButton.isEnabled = false
                playButton.setTitle("pause", for: .normal)
                prepare_play()
                audioPlayer.play()
                isPlaying = true
            }
            else {
                displayAlert(alertTitle: "", msg: "Audio file is missing", actionTitle: "OK")
            }
        }
    }
    
    func displayAlert(alertTitle: String, msg: String, actionTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
        playButton.isEnabled = true
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Encoding Error", error?.localizedDescription ?? "")
    }
    
    //MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
