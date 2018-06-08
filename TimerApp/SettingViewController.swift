//
//  SettingViewController.swift
//  TimerApp
//
//  Created by yuwa on 2018/05/13.
//  Copyright © 2018年 yuwa. All rights reserved.
//

import UIKit

/*****************************************************
 クラス名：SettingViewController
 概要：設定画面コントローラクラス
 *****************************************************/
class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let valueArray : [Int] = [10,30,60,120,180] // ピッカービューのアイテム
    let settingKey = "timerValue" // UserDefaults登録キー
    
    @IBOutlet weak var timerPicker: UIPickerView! // ピッカービュー
    
    //////////////////////////////////////////////////////
    // 画面ロード時の処理
    //////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ピッカーのデリゲート先、データソースをセット
        timerPicker.delegate = self
        timerPicker.dataSource = self
        
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)

        // ピッカーの初期値をセット
        for row in 0..<valueArray.count {
            if valueArray[row] == timerValue {
                timerPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }

    //////////////////////////////////////////////////////
    // メモリエラー時の処理
    //////////////////////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //////////////////////////////////////////////////////
    // 選択する押下時の処理
    //////////////////////////////////////////////////////
    @IBAction func chooseAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //////////////////////////////////////////////////////
    // ピッカービューに表示する列数をセット
    //////////////////////////////////////////////////////
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //////////////////////////////////////////////////////
    // ピッカービューの数をセット
    //////////////////////////////////////////////////////
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return valueArray.count
    }
    
    //////////////////////////////////////////////////////
    // ピッカービューのタイトルをセット
    //////////////////////////////////////////////////////
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(valueArray[row])
    }
    
    //////////////////////////////////////////////////////
    // 秒数選択時の処理
    //////////////////////////////////////////////////////
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let settings = UserDefaults.standard
        settings.setValue(valueArray[row], forKey: settingKey)
        // メモリの値を書き込む（明示的に呼ばなくても一定間隔で書き込まれる）
        settings.synchronize()
    }

}
