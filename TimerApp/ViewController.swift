//
//  ViewController.swift
//  TimerApp
//
//  Created by yuwa on 2018/05/13.
//  Copyright © 2018年 yuwa. All rights reserved.
//

import UIKit

/*****************************************************
 クラス名：ViewController
 概要：タイマー画面コントローラクラス
*****************************************************/
class ViewController: UIViewController {
    
    var timer: Timer?
    var duration = 0 // 経過時間
    let settingKey = "timerValue" // UserDefaults登録キー
    @IBOutlet weak var timeDisplay: UILabel! // 秒数ラベル
    
    
    //////////////////////////////////////////////////////
    // 画面ロード時の処理
    //////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初期値をセット
        let settings = UserDefaults.standard
        settings.register(defaults: [settingKey: 60])
    }

    //////////////////////////////////////////////////////
    // メモリエラー時の処理
    //////////////////////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //////////////////////////////////////////////////////
    // 画面が表示された時の処理
    //////////////////////////////////////////////////////
    override func viewDidAppear(_ animated: Bool) {
        duration = 0
        _ = displayUpdate()
    }
    
    //////////////////////////////////////////////////////
    // 秒数更新処理
    //////////////////////////////////////////////////////
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        let remainSeconds = timerValue - duration
        timeDisplay.text = "あと\(remainSeconds)秒"
        return remainSeconds
    }
    
    //////////////////////////////////////////////////////
    // 設定ボタン押下時の処理
    //////////////////////////////////////////////////////
    @IBAction func settingButtonAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
        performSegue(withIdentifier: "openSetting", sender: nil)
    }
    
    //////////////////////////////////////////////////////
    // スタートボタン押下時の処理
    //////////////////////////////////////////////////////
    @IBAction func startTimerAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        // タイマー作成（この形は暗記する）
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerStop(_:)), userInfo: nil, repeats: true)
    }
    
    //////////////////////////////////////////////////////
    // ストップボタン押下時の処理
    //////////////////////////////////////////////////////
    @IBAction func stopTimerAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
    }
    
    //////////////////////////////////////////////////////
    // タイマー停止処理
    //////////////////////////////////////////////////////
    @objc func timerStop(_ timer:Timer) {
        duration += 1
        if displayUpdate() <= 0 {
            duration = 0
            timer.invalidate()
        }
    }
    
}

