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

class ViewController: UIViewController {

    @IBOutlet weak var lblQuestion: UILabel!

    var categories: [Category] = [];
    var currentCategory = -1;
    var shuffledQuestions : [Question] = [];
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //temporary stuff
        currentCategory = 0;
        //---------------
        
        initQuestions();
        
        shuffledQuestions = shuffleQuestions(questions: categories[currentCategory].questions);


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func btnSkip(_ sender: Any) {
        
        lblQuestion.text = shuffledQuestions[0].question;
    }
    
    
    func shuffleQuestions(questions : [Question]) -> [Question] {
        var questionList = questions;
        questionList.shuffle();
        return questionList;
    }
    
    
    func initQuestions() {
        categories.removeAll(keepingCapacity: false);
        
        categories.append(Category("Sport"));
        categories.append(Category("Science"));
        categories.append(Category("TV"));
        categories.append(Category("History"));
        
        var newQuestion = Question("", "");
        
        newQuestion.question = "Which London team earned the nickname 'The Crazy Gang'?";
        newQuestion.correctAnswer = "Wimbledon FC";
        newQuestion.addAnswer("Manchester United");
        newQuestion.addAnswer("Arsenal");
        newQuestion.addAnswer("Liverpool");
        categories[0].addQuestion(newQuestion);
        newQuestion.answers.removeAll(keepingCapacity: false);
        
        newQuestion.question = "Which manager said he'd been in more courts than Bjorn Borg?";
        newQuestion.correctAnswer = "Tommy Docherty";
        newQuestion.addAnswer("Someone Else");
        newQuestion.addAnswer("Other person");
        newQuestion.addAnswer("Idont know");
        categories[0].addQuestion(newQuestion);
        newQuestion.answers.removeAll(keepingCapacity: false);

        newQuestion.question = "London hosts/hosted the 2012 Olympic Games. In which previous years have London hosted the games?";
        newQuestion.correctAnswer = "1948 and 1908";
        newQuestion.addAnswer("1952 and 1994");
        newQuestion.addAnswer("1982 and 1904");
        newQuestion.addAnswer("1964 and 1972");
        categories[0].addQuestion(newQuestion);
        newQuestion.answers.removeAll(keepingCapacity: false);
        
        
        
        
    }
    
}












