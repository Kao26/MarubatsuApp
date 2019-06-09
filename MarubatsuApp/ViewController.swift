//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by Kaoru Tsugane on 2019/06/08.
//  Copyright © 2019 津金薫. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    //問題の時の音
    var QAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    //正解の時の音
    var YAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    //不正解の時の音
    var NAudioPlayer: AVAudioPlayer = AVAudioPlayer()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //下で作成した関数！！！！！！！
        showQuestion()
        
        //音の準備
        QSound()
        YSound()
        NSound()
        
        //画面起動時に問題が入っていたら出題音を鳴らす
        if UserDefaults.standard.object(forKey: "qAndA") != nil {
            self.QAudioPlayer.play()
            print("問題の中身\(questions)")
            
        }

        
    }

    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    

    var questions: [[String: Any]] = [[:]]
    
    
    //画面遷移時にキーを頼りにpuestionsの配列にデータを保存
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.object(forKey: "qAndA") != nil {
            questions = UserDefaults.standard.object(forKey: "qAndA") as! [[String : Any]]
            //チェック
            print("画面遷移:\(questions)")
            
            showQuestion()
            
        }
    
        
    }
    
    
    
    //問題を表示させる関数を作成する！！！！----------------------------------------
    func showQuestion() {
        //新しい定数questionに配列(currentQuestionNumの値を取り出す(初期値０で設定してるやつ))を格納
        //ここで定数として宣言したquestionも辞書になる！！！！！！
        //なぜなら、辞書を格納したから！！！
        let question = questions[currentQuestionNum]
        
        //定数queを定義して、questionという辞書のなかの["question"]を取り出す！！！
        if let que = question["question"] as? String{
            //問題番号がつくようにした
            questionLabel.text = "[問題\(currentQuestionNum + 1)]  " + que
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
                self.YAudioPlayer.play()
                
            }else {
                //不正解の時はここに来る
                showAlertN(message: "不正解")
                self.NAudioPlayer.play()
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
    
    
    
    
    
    
    
    
    
    //アラートをつける関数を作る正解バージョン出題音あり---------------------------------------------------------
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message , preferredStyle: .alert)
        
//        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        let close = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.QAudioPlayer.play()
        }
        
        alert.addAction(close)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //アラートをつける関数を作る不正解バージョン出題音なし---------------------------------------------------------
    func showAlertN(message: String) {
        
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
    
    //問題の時の音の関数
    func QSound(){
        if let sound = Bundle.main.path(forResource: "Q", ofType: ".mp3"){
            QAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            QAudioPlayer.prepareToPlay()
        }
    }
    
    //正解の時の音の関数
    func YSound(){
        if let sound = Bundle.main.path(forResource: "Y", ofType: ".mp3"){
            YAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            YAudioPlayer.prepareToPlay()
        }
    }
    
    //不正解の時の音の関数
    func NSound(){
        if let sound = Bundle.main.path(forResource: "N", ofType: ".mp3"){
            NAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            NAudioPlayer.prepareToPlay()
        }
    }
    
    
    
}

