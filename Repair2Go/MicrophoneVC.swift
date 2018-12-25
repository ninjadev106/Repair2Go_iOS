//
//  MicrophoneVC.swift
//  Repair2Go
//
//  Created by mobile on 12/24/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import AVFoundation

class MicrophoneVC: UIViewController {
    
    @IBOutlet weak var lblMicrophone: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    var currentInputDataSourceMode: inputDataSourceMode?
    enum inputDataSourceMode: String {
        case
        top = "Top",
        back = "Back",
        front = "Front"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentInputDataSourceMode = inputDataSourceMode.top
        
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
    
    func setRecordPermissions() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
    }
    
    @IBAction func onTappedBtnChangeMicrophone(_ sender: Any) {
        if currentInputDataSourceMode == inputDataSourceMode.top {
            currentInputDataSourceMode = inputDataSourceMode.back
            return
        }
    }
    
    @IBAction func onTappedBtnRecord(_ sender: Any) {
        
    }
    
    @IBAction func onTappedBtnPlay(_ sender: Any) {
        
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
