//
//  ViewController.swift
//  SBProgressView
//
//  Created by 王晓冬 on 16/8/21.
//  Copyright © 2016年 CaiShengbo. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.mainScreen().bounds.size.width;
let kScreenHeight = UIScreen.mainScreen().bounds.size.height;

class ViewController: UIViewController {
    
    private var progressView:SBProgressView!;
    
    private var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton(type: UIButtonType.System);
        button.setTitle("start", forState: UIControlState.Normal);
        button.frame = CGRectMake((kScreenWidth - 200)/3.0, kScreenHeight - 80, 100, 50);
        button.addTarget(self, action: #selector(buttonClick), forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(button);
        
        self.progressView = SBProgressView(frame: CGRectMake(0, 0, 100, 200));
        progressView.center = self.view.center;
        progressView.removeWhenCompletion = false;
        self.view.addSubview(self.progressView);
        
        let cancelButton = UIButton(type: UIButtonType.System);
        cancelButton.setTitle("pause", forState: UIControlState.Normal);
        cancelButton.frame = CGRectMake((kScreenWidth - 200)/3.0*2.0 + 100, kScreenHeight - 80, 100, 50);
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(cancelButton);
        
    }

    
    func buttonClick() {
        print("-----------------> buttonClick");
        if (timer != nil) {
            return;
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(improveProgressView), userInfo: nil, repeats: true);
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes);
    }
    
    func improveProgressView() {
        self.progressView.progress = self.progressView.progress + 0.05;
        if (self.progressView.progress >= 1) {
            self.progressView.progress = 0;
        }
    }
    
    
    func cancelButtonClick() {
        print("-----------------> cancelButtonClick");
        if (timer != nil) {
            timer.invalidate();
            timer = nil;
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

