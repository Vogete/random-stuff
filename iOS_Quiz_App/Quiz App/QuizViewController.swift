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


class QuizViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tblChoices: UITableView!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    var currentCategory : Category?
    var shuffledQuestions : [Question] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        shuffledQuestions = shuffleQuestions(questions: (currentCategory?.questions)!);

        if shuffledQuestions.count > 0 {
            lblQuestion.text = shuffledQuestions[0].question
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func btnSkip(_ sender: Any) {
        shuffledQuestions.append(shuffledQuestions.remove(at: 0))
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
        self.tblChoices.reloadData()
        
        if shuffledQuestions.count > 0 {
            lblQuestion.text = shuffledQuestions[0].question
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (currentCategory?.questions.count)! > 0 {
            return shuffledQuestions[0].answers.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = shuffledQuestions[0].answers[indexPath.row]
        
        return cell
    }
    
}












