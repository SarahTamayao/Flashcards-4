//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Gareth Waughan on 3/6/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var ExtraAnswer1TextField: UITextField!
    @IBOutlet weak var ExtraAnswer2TextField: UITextField!
    
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    var initialExtraAns1: String?
    var initialExtraAns2: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        
        ExtraAnswer1TextField.text = initialExtraAns1
        ExtraAnswer2TextField.text = initialExtraAns2
        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnEnter(_ sender: Any) {
        
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        let extraAnswer1Text = ExtraAnswer1TextField.text
        
        let extraAnswer2Text = ExtraAnswer2TextField.text
        
        
        if(questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty)
        {
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle:.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            
            present(alert, animated: true)
            alert.addAction(okAction)
        }
        
        else{
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraAnswer1Text, extraAnswerTwo: extraAnswer2Text)

            
            dismiss(animated: true)
        }

    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
