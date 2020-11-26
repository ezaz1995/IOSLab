//
//  StartViewController.swift
//  IOS Quiz app
//
//  Created by Sha Nawaz Hathalia on 2020-11-15.
//

import UIKit

class StartViewController: UIViewController {
   
    

    @IBOutlet weak var enterRoundsTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    var difficulty = ""
    var amount = 0
    var questions: [Question] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = false
       
    }
    
    @IBAction func highscoreButtonHandler(_ sender: Any) {
        let highscoreTableViewController = HighscoreTableViewController()
        navigationController?.pushViewController(highscoreTableViewController, animated: true)
    }
    

    @IBAction func easyButton(_ sender: Any) {
        if(amount != Int(enterRoundsTextField.text!)){
            difficulty = "easy"
            amount = Int(enterRoundsTextField.text!)!
            downloadQuestions(amount: amount, difficulty: difficulty)
        }else{
            checksValidationForRounds()
        }
    }
    
    @IBAction func mediumButton(_ sender: Any) {
        if(amount != Int(enterRoundsTextField.text!)){
            difficulty = "medium"
            amount = Int(enterRoundsTextField.text!)!
            downloadQuestions(amount: amount, difficulty: difficulty)
        }else{
            checksValidationForRounds()
        }
    }
    
    @IBAction func hardButton(_ sender: Any) {
        if(amount != Int(enterRoundsTextField.text!)){
            difficulty = "hard"
            amount = Int(enterRoundsTextField.text!)!
            downloadQuestions(amount: amount, difficulty: difficulty)
        }else{
            checksValidationForRounds()
        }
    }
    
    
    
    func downloadQuestions(amount: Int, difficulty: String){
        guard let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)&difficulty=\(difficulty)&type=multiple") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data else{
                print(error)
                return
            }
            
            print(String(data: data, encoding: .utf8))
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let questionsResult = try? decoder.decode(QuestionsResult.self, from: data)
            self?.questions = questionsResult?.results ?? []
            
            DispatchQueue.main.async {
                self?.startButton.isEnabled = true
            }
            
        }
        task.resume()
    }
    
    
    func checksValidationForRounds(){
        let alertController = UIAlertController(title: "Invalid input", message: "You have to enter how many rounds", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: {(_) in alertController.dismiss(animated: true, completion: nil)}))
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? GameViewController {
            questionViewController.numberOfQuestions = questions.count
            questionViewController.questions = questions
    
        }
    }

}
