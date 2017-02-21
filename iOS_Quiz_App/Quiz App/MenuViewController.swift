//
//  MenuViewController.swift
//  Quiz App
//
//  Created by Zoltan Fraknoi on 21/02/2017.
//  Copyright © 2017 Zoltan Fraknoi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource {
    
    var categories: [Category] = [];

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = "hello"
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initQuestions();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
