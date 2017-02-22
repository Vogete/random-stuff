//
//  Category.swift
//  Quiz App
//
//  Created by Zoltan Fraknoi on 19/02/2017.
//  Copyright © 2017 Zoltan Fraknoi. All rights reserved.
//

import UIKit

struct Category {
    var categoryName = "";
    var questions: [Question] = [];
    
    
    init(_ name: String) {
        categoryName = name;
    }
    
    mutating func addQuestion(_ question : Question) {
        self.questions.append(question);
    }
}


struct Question {
    var question: String = "";
    var correctAnswer: Int = 0;
    var answers: [String] = [];
    
    init(_ question: String, _ correctAnswer: Int = 0) {
        self.question = question;
        self.correctAnswer = correctAnswer;
    }
    
    mutating func addAnswer(_ answer: String) {
        self.answers.append(answer);
    }
}
