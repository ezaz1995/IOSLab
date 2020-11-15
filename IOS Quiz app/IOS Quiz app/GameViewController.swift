//
//  GameViewController.swift
//  IOS Quiz app
//
//  Created by Sha Nawaz Hathalia on 2020-11-15.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonAnswerA: UIButton!
    @IBOutlet weak var buttonAnswerB: UIButton!
    @IBOutlet weak var buttonAnswerC: UIButton!
    @IBOutlet weak var buttonAnswerD: UIButton!
    
    private var haveWon = false
    var questions: [Question] = [] {
        didSet {
            question = questions.removeFirst()
        }
    }
    var question: Question? 
    var numberOfQuestions = 0
    var rightAnswers = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        //Configure of the question label
        questionLabel.clipsToBounds = true
        questionLabel.layer.cornerRadius = 20
        
        var buttons = [buttonAnswerA, buttonAnswerB, buttonAnswerC, buttonAnswerD]
        //Configuration of the buttons
        buttons.forEach{(button) in button?.layer.cornerRadius = 20
        }
        
        questionLabel.text = question?.question
        buttons.shuffle()
        let correctButton = buttons.removeFirst()
        correctButton?.setTitle(question?.correctAnswer, for: .normal)
        
        question?.incorrectAnswer.forEach({ (answer) in
            let button = buttons.removeFirst()
            button?.setTitle(answer, for: .normal)
        })
    }
    
  
    @IBAction func buttonAnswerAHandler(_ sender: Any) {
        if buttonAnswerA.title(for: .normal) == question?.correctAnswer{
            showRightAnswer(button: buttonAnswerA)
        }else {
            showWrongAnswer(button: buttonAnswerA)
        }
    }
    

    @IBAction func buttonAnswerBHandler(_ sender: Any) {
        if buttonAnswerB.title(for: .normal) == question?.correctAnswer{
            showRightAnswer(button: buttonAnswerB)
        }else {
            showWrongAnswer(button: buttonAnswerB)
        }
    }
    
    
    @IBAction func buttonAnswerCHandler(_ sender: Any) {
        if buttonAnswerC.title(for: .normal) == question?.correctAnswer{
            showRightAnswer(button: buttonAnswerC)
        }else {
            showWrongAnswer(button: buttonAnswerC)
        }
    }
    
    @IBAction func buttonAnswerDHandler(_ sender: Any) {
        if buttonAnswerD.title(for: .normal) == question?.correctAnswer{
            showRightAnswer(button: buttonAnswerD)
        }else {
            showWrongAnswer(button: buttonAnswerD)
        }
    }
    
    
    
    private func showWrongAnswer(button: UIButton) {
        button.backgroundColor = .red
        haveWon = false
        let alertController = UIAlertController(title: "Wrong answer", message: "Next time", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: { [weak self] (_) in self?.goToNextScreen()}))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showRightAnswer(button: UIButton){
        haveWon = true
        rightAnswers += 1
        button.backgroundColor = .green
        let alertController = UIAlertController(title: "Right answer", message: "Awesome!", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: { [weak self] (_) in self?.goToNextScreen()}))
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func goToNextScreen() {
        guard questions.isEmpty == false,
            let questionViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
            performSegue(withIdentifier: "ResultView", sender: nil)
            return
        }
        
        questionViewController.numberOfQuestions = numberOfQuestions
        questionViewController.rightAnswers = rightAnswers
        questionViewController.questions = questions
        navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    // MARK: - Navigation
    
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController{
            resultViewController.resultView.resultLabel.text = "You answered \(rightAnswers) right from \(numberOfQuestions) questions."
        }
    }
    
}
