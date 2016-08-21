//
//  SBProgressHUD.swift
//  ImageHandleTesting
//
//  Created by mengdong on 16/8/13.
//  Copyright © 2016年 mengdong. All rights reserved.
//

import UIKit

class SBProgressView: UIView {
    /// 进度条
    private var circleLayer:CAShapeLayer!
    /// 显示进度数字的label
    private var progressLabel:UILabel!
    /// 背景条的宽度
    private let backgroundLineWidth:CGFloat = 8;
    /// 进度条的宽度，比背景条稍宽，不至于露出下面的条，丑
    private let progressLineWidth:CGFloat = 12;
    /// 进度
    var progress:CGFloat! = 0.0 {
        didSet {
            if (progress >= 1) {
                progress = 1;
            }
            self.setProgress();
        }
    }
    
    /// 百分之百后是否移除
    var removeWhenCompletion:Bool = true;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        self.backgroundColor = UIColor.whiteColor();
        
        setUpSubLayer();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubLayer() {
        
        let radius = (self.bounds.width > self.bounds.height ? self.bounds.height/2.0 : self.bounds.width/2.0) - backgroundLineWidth/2.0;
        let layerCenter = CGPointMake(self.bounds.width/2.0, self.bounds.height/2.0);
        
        // 画一个圆形的path
        let shadowBezierPath = UIBezierPath(arcCenter: layerCenter, radius: radius, startAngle: 0, endAngle: 2*CGFloat(M_PI), clockwise: true);
        let shadowLayer = CAShapeLayer();
        // 填充色
        shadowLayer.fillColor = UIColor.clearColor().CGColor;
        // 边框色
        shadowLayer.strokeColor = UIColor.blackColor().CGColor;
        shadowLayer.frame = self.bounds;
        // 边框的宽度
        shadowLayer.lineWidth = backgroundLineWidth;
        shadowLayer.path = shadowBezierPath.CGPath;
        self.layer.addSublayer(shadowLayer);
        
        circleLayer = CAShapeLayer();
        circleLayer.fillColor = UIColor.clearColor().CGColor;
        circleLayer.strokeColor = UIColor(red: 214/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1.0).CGColor;
        /// 这个是设置线的头部是圆角
        circleLayer.lineCap = kCALineCapRound;
        circleLayer.frame = self.bounds;
        circleLayer.lineWidth = progressLineWidth;
        self.layer.addSublayer(circleLayer);
        
        progressLabel = UILabel();
        progressLabel.font = UIFont.boldSystemFontOfSize(14);
        progressLabel.textColor = UIColor.blackColor();
        progressLabel.numberOfLines = 1;
        progressLabel.textAlignment = NSTextAlignment.Center;
        progressLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
        self.addSubview(progressLabel);
        
        setProgress();
    }
    
    
    func setProgress() {
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.progressLabel.text = String(format: "%.0f", self.progress*100);
            self.progressLabel.sizeToFit();
            var labFrame = self.progressLabel.frame;
            labFrame = CGRectMake((self.frame.width - self.progressLabel.frame.width)/2.0, (self.frame.height - self.progressLabel.frame.height)/2.0, self.progressLabel.frame.width, self.progressLabel.frame.height);
            self.progressLabel.frame = labFrame;
            
            var p = self.progress;
            if (self.progress < 0.01) {
                p = 0.01;
            }
            
            
            let radius = (self.bounds.width > self.bounds.height ? self.bounds.height/2.0 : self.bounds.width/2.0) - self.backgroundLineWidth/2.0;
            
            let bezierPath = UIBezierPath(arcCenter: CGPointMake(self.frame.width/2.0, self.frame.height/2.0), radius: radius, startAngle: CGFloat(-M_PI_2), endAngle: p*360/180*CGFloat(M_PI) - CGFloat(M_PI_2), clockwise: true);
            self.circleLayer.path = bezierPath.CGPath;
            
            if (self.progress == 1 && self.removeWhenCompletion) {
                self.removeFromSuperview();
            }
        }
    }
    
}

class ProgressView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


