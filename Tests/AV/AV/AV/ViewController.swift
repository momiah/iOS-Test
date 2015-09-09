//
//  ViewController.swift
//  AV
//
//  Created by Muhammed Miah on 09/09/2015.
//  Copyright (c) 2015 Muhammed Miah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    
    // To be able to save image from camera
    let stillImageOutput = AVCaptureStillImageOutput()
    
    // Front-facing camera
    var captureDevice : AVCaptureDevice?
    
    var previewLayer : AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession.sessionPreset = AVCaptureSessionPresetLow
        
        // Find available devices
        let devices = AVCaptureDevice.devices()
        
        // Loop through all the capture devices on this phone
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the front camera
                if(device.position == AVCaptureDevicePosition.Front) {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        if captureDevice != nil {
            beginSession()
        } else {
            println("Front-facing camera not found")
        }
        
        // Detect the screen orientation changing, so that preview control's size can be updated
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated",
            name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginSession() {
        var err : NSError? = nil
        
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        captureSession.startRunning()
        
        
        // To display camera footage
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame
        previewLayer?.zPosition = -1
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // To take pictures
        stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
        
        if captureSession.canAddOutput(stillImageOutput) {
            captureSession.addOutput(stillImageOutput)
        }
    }
    
    func rotated() {
        // Attempted to display camera footage always fullscreen
        
//        if UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.Portrait {
//            previewLayer?.transform = CATransform3DMakeRotation(0, 0, 0, 0)
//            
//        } else if UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.PortraitUpsideDown {
//            previewLayer?.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 0)
//            
//        } else if UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.LandscapeLeft {
//            previewLayer?.transform = CATransform3DMakeRotation(CGFloat(M_PI)/2, 0, 0, 0)
//            
//        } else if UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.LandscapeRight {
//            previewLayer?.transform = CATransform3DMakeRotation(3*CGFloat(M_PI)/2, 0, 0, 0)
//            
//        }
        
        previewLayer?.frame = self.view.bounds
        
    }
    
    @IBAction
    func takePhoto() {
        
        if let videoConnection = stillImageOutput.connectionWithMediaType(AVMediaTypeVideo) {
            stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection) {
                (imageDataSampleBuffer, error) -> Void in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData), nil, nil, nil)
            }
        }
        
    }

}

