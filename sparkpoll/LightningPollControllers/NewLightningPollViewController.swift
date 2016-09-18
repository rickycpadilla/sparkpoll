//
//  NewLightningPollViewController.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/17/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import Speech

class NewLightningPollViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    private var speechRecognizer: SFSpeechRecognizer!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest!
    private var recognitionTask: SFSpeechRecognitionTask!
    private let audioEngine = AVAudioEngine()
    private var locales: [Locale]!
    private let defaultLocale = Locale(identifier: "en-US")
    
    @IBOutlet weak var pollNameTextInput: UITextField!
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startRecordingButton.isEnabled = false
        // english, do you speak it!?
        prepareRecognizer(locale: defaultLocale)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            /*
             The callback may not be called on the main thread. Add an
             operation to the main queue to update the record button's state.
             */
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.startRecordingButton.isEnabled = true
                    
                case .denied:
                    self.startRecordingButton.isEnabled = false
                    self.startRecordingButton.setTitle("User denied access to speech recognition", for: .disabled)
                    
                case .restricted:
                    self.startRecordingButton.isEnabled = false
                    self.startRecordingButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.startRecordingButton.isEnabled = false
                    self.startRecordingButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func prepareRecognizer(locale: Locale) {
        speechRecognizer = SFSpeechRecognizer(locale: locale)!
        speechRecognizer.delegate = self
    }
    
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true
        
        // A recognition task represents a speech recognition session.
        // We keep a reference to the task so that it can be cancelled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                self.textView.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.startRecordingButton.isEnabled = true
                self.startRecordingButton.setTitle("Start Recording", for: [])
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
        
        textView.text = "(listening...)"
    }
    
    // =========================================================================
    // MARK: - SFSpeechRecognizerDelegate
    
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            startRecordingButton.isEnabled = true
            startRecordingButton.setTitle("Start Recording", for: [])
        } else {
            startRecordingButton.isEnabled = false
            startRecordingButton.setTitle("Recognition not available", for: .disabled)
        }
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func recordBtnTapped() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            startRecordingButton.isEnabled = false
            startRecordingButton.setTitle("Stopping", for: .disabled)
        } else {
            try! startRecording()
            startRecordingButton.setTitle("Stop recording", for: [])
        }
    }
}
