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
    
    var currentCategory = -1;
    var shuffledQuestions : [Question] = [];
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //temporary stuff
        currentCategory = 0;
        //---------------
        
        
        // shuffledQuestions = shuffleQuestions(questions: categories[currentCategory].questions);


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func btnSkip(_ sender: Any) {
        
//        lblQuestion.text = shuffledQuestions[0].question;
    }
    
    
    func shuffleQuestions(questions : [Question]) -> [Question] {
        var questionList = questions;
        questionList.shuffle();
        return questionList;
    }
    
    

    
}












