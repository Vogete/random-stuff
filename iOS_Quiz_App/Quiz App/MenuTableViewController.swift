//
//  MenuTableViewController.swift
//  Quiz App
//
//  Created by Zoltan Fraknoi on 22/02/2017.
//  Copyright © 2017 Zoltan Fraknoi. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var categories: [Category] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initQuestions()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = categories[indexPath.row].categoryName
        cell.detailTextLabel?.text = String(categories[indexPath.row].questions.count) + " questions"

        return cell
    }
    

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let quizScene = segue.destination as! QuizViewController
        
        // Pass the selected object to the new view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedCategory = categories[indexPath.row]
            quizScene.currentCategory = selectedCategory
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    func initQuestions() {
        categories.removeAll(keepingCapacity: false);
        
        categories.append(Category("Sport"));
        categories.append(Category("Science"));
        categories.append(Category("TV"));
        categories.append(Category("History"));
        
        var newQuestion = Question("");
        
        newQuestion.question = "Which London team earned the nickname 'The Crazy Gang'?";
        newQuestion.addAnswer("Wimbledon FC");
        newQuestion.addAnswer("Manchester United");
        newQuestion.addAnswer("Arsenal");
        newQuestion.addAnswer("Liverpool");
        categories[0].addQuestion(newQuestion);
        newQuestion.answers.removeAll(keepingCapacity: false);
        
        newQuestion.question = "Which manager said he'd been in more courts than Bjorn Borg?";
        newQuestion.addAnswer("Tommy Docherty");
        newQuestion.addAnswer("Someone Else");
        newQuestion.addAnswer("Other person");
        newQuestion.addAnswer("Idont know");
        categories[0].addQuestion(newQuestion);
        newQuestion.answers.removeAll(keepingCapacity: false);
        
        newQuestion.question = "London hosts/hosted the 2012 Olympic Games. In which previous years have London hosted the games?";
        newQuestion.addAnswer("1948 and 1908");
        newQuestion.addAnswer("1952 and 1994");
        newQuestion.addAnswer("1982 and 1904");
        newQuestion.addAnswer("1964 and 1972");
        categories[0].addQuestion(newQuestion);
        newQuestion.answers.removeAll(keepingCapacity: false);
        
    }
    

}
