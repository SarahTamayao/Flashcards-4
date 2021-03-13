//
//  ViewController.swift
//  Flashcards
//
//  Created by Gareth Waughan on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var card: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //card.clipsToBounds = true;
        card.layer.shadowRadius = 35.0;
        card.layer.shadowOpacity = 0.5;
        card.layer.cornerRadius = 20.0;
        
   //     frontLabel.cornerRadius = 20.0;
   //     backLabel.cornerRadius = 20.0;
        frontLabel.clipsToBounds = true;
        backLabel.clipsToBounds = true;
        
        btnOptionOne.layer.borderWidth = 3.0;
        btnOptionOne.layer.cornerRadius = 20.0;
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1);
        
        btnOptionTwo.layer.borderWidth = 3.0;
        btnOptionTwo.layer.cornerRadius = 20.0;
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1);
        
        btnOptionThree.layer.borderWidth = 3.0;
        btnOptionThree.layer.cornerRadius = 20.0;
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1);
        
        // Do any additional setup after loading the view.
    }


    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        if(frontLabel.isHidden == false)
        {
            frontLabel.isHidden = true;
            return;
        }
        
        else if(frontLabel.isHidden == true)
        {
            frontLabel.isHidden = false;
            return;
        }
        
        
    }
    
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?) {
        frontLabel.text = question
        backLabel.text = answer
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)

        
        
    }
    
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true;
        
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true;
        btnOptionTwo.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1);
        
        if(btnOptionOne.isHidden == false || btnOptionThree.isHidden == false)
        {
            btnOptionOne.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1);
            btnOptionThree.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1);
        }
        
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true;
        
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
       
        if(segue.identifier == "EditSegue")
        {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            creationController.initialAnswer =
                btnOptionTwo.currentTitle
            creationController.initialExtraAns1 = btnOptionOne.currentTitle
            creationController.initialExtraAns2 = btnOptionThree.currentTitle
        
        }
        creationController.flashcardsController = self
    }
}
