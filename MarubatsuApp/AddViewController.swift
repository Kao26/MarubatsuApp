//
//  AddViewController.swift
//  MarubatsuApp
//
//  Created by Kaoru Tsugane on 2019/06/09.
//  Copyright © 2019 津金薫. All rights reserved.
//

import UIKit


class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //textFieldに始めに表示しておく文字と色の指定
        textField.attributedPlaceholder = NSAttributedString(string: "ここに問題を入力してください。", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        //画面が読み込まれた時にデータを配列に保存
        if UserDefaults.standard.object(forKey: "qAndA") != nil {
            data = UserDefaults.standard.object(forKey: "qAndA") as! [[String : Any]]
            //チェック
            print("追加画面ロード時:\(data)")
            
        }

        // Do any additional setup after loading the view.
    }
    
    

    //テキストフィールド

    @IBOutlet weak var textField: UITextField!
    
    //答え設定のブール値が入る
    var answer: Bool!
    //yesとnoの切り替え画面
    @IBAction func yesNoButton(_ sender: UISegmentedControl) {
        //セグメント番号で条件分岐させる
        switch sender.selectedSegmentIndex {
        case 0:
            answer = false
            
        case 1:
            answer = true

        default:
            print("エラー")
        }
    }
    

    
    //問題と正解が格納される
    var data: [[String: Any]] = []
    
    
    
    //保存する
    @IBAction func saveQuestionButton(_ sender: Any) {
        
        
        if textField.text == "" {
            showAlert2(message: "問題を追加してください")
            
        //セグメントコントロールが選択されなかった時
        }else if answer == nil {
            showAlert2(message: "○×を選択してください\n×を選択する場合、⚪︎を一度選択してから×を選択してください。")
            
        }else {
            var ques = textField.text!
            
            //配列に入れる
            data.append(["question": ques, "answer": answer])
            
            textField.text = ""
            
            
            //ユーザーデフォルトにデータを保存
            UserDefaults.standard.set( data, forKey: "qAndA" )
            print("保存したデータ\(data)")
        }
        
    }
    
    
    
    //問題をすべて削除
    @IBAction func removeQuestionButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "qAndA")
        showAlert2(message: "すべて削除しました")
        
    }
    
    
    
    
    //アラートをつける関数を作る---------------
    func showAlert2(message: String) {
        
        let alert = UIAlertController(title: nil, message: message , preferredStyle: .alert)
        
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        alert.addAction(close)
        
        present(alert, animated: true, completion: nil)
        
    }
    

    
    
}


