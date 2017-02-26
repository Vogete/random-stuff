//
//  ViewController.swift
//  Quiz App
//
//  Created by Zoltan Fraknoi on 19/02/2017.
//  Copyright © 2017 Zoltan Fraknoi. All rights reserved.
//

import UIKit

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}


class QuizViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblChoices: UITableView!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var buttonSkip: UIButton!
    
    var currentCategory : Category?
    var shuffledQuestions : [Question] = []
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.

        shuffledQuestions = shuffleQuestions(questions: (currentCategory?.questions)!);

        if shuffledQuestions.count > 0 {
            lblQuestion.text = shuffledQuestions[0].question
        } else {
            buttonSkip.isEnabled = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func btnSkip(_ sender: Any) {
        shuffledQuestions[0] = shuffleAnswers(question: shuffledQuestions[0])
        shuffledQuestions.append(shuffledQuestions.remove(at: 0))
        refreshView()
    }
    
    func nextQuestion() {
        shuffledQuestions.remove(at: 0)
        refreshView()
    }
    
    
    func shuffleQuestions(questions : [Question]) -> [Question] {
        
        var questionList = questions
        questionList.shuffle()

        for var i in (0..<questionList.count) {
            questionList[i] = shuffleAnswers(question: questionList[i])
        }
        
        return questionList
    }
    
    func shuffleAnswers(question : Question) -> Question {
        
        let rightAnswer = question.answers[question.correctAnswer]
        var currentQuestion = question
        currentQuestion.answers.shuffle()
        
        for var i in (0..<currentQuestion.answers.count) {
            if currentQuestion.answers[i] == rightAnswer {
                currentQuestion.correctAnswer = i
            }
        }
        
        return currentQuestion
    }
    
    func refreshView() {
        
        
        if shuffledQuestions.count > 0 {
            lblQuestion.text = shuffledQuestions[0].question
        } else {
            lblQuestion.text = "Game Over"
            self.buttonSkip.isEnabled = false
        }
            self.tblChoices.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (shuffledQuestions.count) > 0 {
            return shuffledQuestions[0].answers.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = shuffledQuestions[0].answers[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell : UITableViewCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        tableView.isUserInteractionEnabled = false
        buttonSkip.isEnabled = false
        
        if indexPath.row == shuffledQuestions[0].correctAnswer {
            selectedCell.contentView.backgroundColor = UIColor.green
            score += 1
            lblScore.text = "Score: " + String(score)
            
        } else {
            selectedCell.contentView.backgroundColor = UIColor.red
        }

        
        var timer : Timer?
        
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false){timer in
            tableView.isUserInteractionEnabled = true
            self.buttonSkip.isEnabled = true
            self.nextQuestion()
        }
        
    }
    
    
    
}












