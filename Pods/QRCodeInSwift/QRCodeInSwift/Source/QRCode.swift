//
//  QRCode.swift
//  QRCodeInSwift
//
//  Created by 李禹 on 15/9/13.
//  Copyright (c) 2015年 dayu. All rights reserved.
//

import Foundation
import AVFoundation

public class QRCode: NSObject {
    public override init() {}
    
//    var completion: ((stringValue: String)->())?
    public func sayHello () {
        NSLog("hello");
    }
//    
//    //摄像头输入
//    lazy var videoInput: AVCaptureDeviceInput? = {
//        if let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo) {
//            
//            return AVCaptureDeviceInput.deviceInputWithDevice(device, error: nil) as? AVCaptureDeviceInput;
//        }
//        return nil;
//        }()
//    
//    //输出数据
//    lazy var output: AVCaptureMetadataOutput = {
//        return AVCaptureMetadataOutput();
//        }();
//    
//    //会话
//    lazy var session: AVCaptureSession = {
//        let session = AVCaptureSession();
//        
//        return session;
//        
//        }();
//    
//    //预览图层
//    lazy var previewLayer: AVCaptureVideoPreviewLayer? = {
//        let previewLayer = AVCaptureVideoPreviewLayer.layerWithSession(self.session) as? AVCaptureVideoPreviewLayer;
//        return previewLayer;
//        }()
//    
//    //二维码边框
//    lazy var boundsView: UIView = {
//        let view = UIView();
//        return view;
//        }()
//
//    
//    public func startScan(fromView: UIView, previewFrame: CGRect, boarderColor: UIColor, boarderWidth: CGFloat,  completion:(qrcode:String)->()) {
//        if (session.canAddInput(videoInput)) {
//            session.addInput(videoInput);
//        }
//        if (session.canAddOutput(output)) {
//            session.addOutput(output);
//        }
//        //设置扫描数据类型（全部支持）
//        output.metadataObjectTypes = output.availableMetadataObjectTypes;
//        println(output.availableMetadataObjectTypes);
//        
//        previewLayer?.frame = previewFrame;
//        fromView.layer.insertSublayer(previewLayer, atIndex: 0);
//        
//        fromView.frame = CGRectZero;
//        fromView.layer.borderWidth = boarderWidth;
//        fromView.layer.borderColor = boarderColor.CGColor;
//        fromView.addSubview(boundsView);
//        
//        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue());
//        
//        session.startRunning();
//        
//    }
}

extension QRCode: AVCaptureMetadataOutputObjectsDelegate {
    
//    public func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
//        if (metadataObjects == nil || metadataObjects.count == 0) {
//            return;
//        }
//        
//        let readableCodeObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject;
//        if (readableCodeObj == nil) {
//            return
//        }
//        if readableCodeObj!.type == AVMetadataObjectTypeQRCode {
//                let codeObject = previewLayer?.transformedMetadataObjectForMetadataObject(readableCodeObj!);
//                if codeObject != nil {
//                    boundsView.frame = codeObject!.bounds;
//                    let str = readableCodeObj!.stringValue;
//                    if str == nil { return; }
//                    self.completion?(stringValue: str);
//                    
//                }
//        }
//    }
}
