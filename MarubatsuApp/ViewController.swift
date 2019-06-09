//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by Kaoru Tsugane on 2019/06/08.
//  Copyright © 2019 津金薫. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //下で作成した関数！！！！！！！
        showQuestion()
        
    }

    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    
    //問題を格納する辞書を設定する
    //アクセスする方をString、辞書内の型名はなんでもいいのでAnyを使う
    let questions: [[String: Any]] = [
        
        [
            //問題と答えをセットで辞書に格納している
            "question": "iPhoneアプリを開発する統合環境はZcodeである",
            "answer": false
        ],
        [
            "question": "Xcode画面の右側にはユーティリティーズがある",
            "answer": true
        ],
        [
            "question": "UILabelは文字列を表示する際に利用する",
            "answer": true
        ]
    
    ]
    
    
    
    
    
    
    //問題を表示させる関数を作成する！！！！----------------------------------------
    func showQuestion() {
        //新しい定数questionに配列(currentQuestionNumの値を取り出す(初期値０で設定してるやつ))を格納
        //ここで定数として宣言したquestionも辞書になる！！！！！！
        //なぜなら、辞書を格納したから！！！
        let question = questions[currentQuestionNum]
        
        //定数queを定義して、questionという辞書のなかの["question"]を取り出す！！！
        if let que = question["question"] as? String{
            questionLabel.text = que
        }
    }
    
    
    
    
    
    
    //回答した時の関数を作る！！！！---------------------------------------------
    //Boolの設定はture,falseなどを扱うから(questionsという辞書の(currentQuestionNum)番目の辞書をquestinに格納する。question内の"answer"を取り出す。)
    func checkAnswer(yourAnswer: Bool) {
        
        //新しい定数questionに配列(currentQuestionNumの値を取り出す)を格納
        let question = questions[currentQuestionNum]
        
        //questonという配列のなかの"answer"を取り出して、ansという定数に格納する
        if let ans = question["answer"] as? Bool {
            //正解の時はここに来る
            //上で答えを格納したans（questionの配列から取り出したbool値）と、yourAnswerを比較している
            if yourAnswer == ans {
                currentQuestionNum += 1
                showAlert(message: "正解")
                
            }else {
                //不正解の時はここに来る
                showAlert(message: "不正解")
                
            }
        }else {
            //答えを設定していなかった時に落ちてエラーを回避するコード
            print("答えがありません")
            return
            
        }
    //currentQuestionNum（初期値０のやつ）が足されていくけど、questionsという辞書の中身の数より多くなったら足すのをやめるってこと
        //>=にしているのは、currentQuestionNumが辞書なので、0から始まるからです！！
        if currentQuestionNum >= questions.count{
            currentQuestionNum = 0
        }
        
        
        // 問題を表示します。
        // 正解であれば次の問題が、不正解であれば同じ問題が再表示されます。
        showQuestion()
    }
    
    
    
    
    
    
    
    
    
    //アラートをつける関数を作る---------------------------------------------------------
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message , preferredStyle: .alert)
        
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        alert.addAction(close)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func tappNoButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    
    @IBAction func tappYesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
    
    
    
}

