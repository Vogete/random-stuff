//
//  Category.swift
//  Quiz App
//
//  Created by Zoltan Fraknoi on 19/02/2017.
//  Copyright © 2017 Zoltan Fraknoi. All rights reserved.
//

import UIKit

class Category {
    var categoryName = "";
    var questions: [Question] = [];
    
    
    init(_ name: String) {
        categoryName = name;
    }
    
    func addQuestion(_ question : Question) {
        self.questions.append(question);
    }
}


struct Question {
    var question: String = "";
    var correctAnswer: String = "";
    var answers: [String] = [];
    
    
    init(_ question: String, _ correctAnswer: String) {
        self.question = question;
        self.correctAnswer = correctAnswer;
    }
    
    mutating func addAnswer(_ answer: String) {
        self.answers.append(answer);
    }
}
