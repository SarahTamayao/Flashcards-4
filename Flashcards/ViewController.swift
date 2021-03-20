//
//  ViewController.swift
//  Flashcards
//
//  Created by Gareth Waughan on 2/20/21.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    
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
        
        
        prevButton.layer.borderWidth = 1.0;
        prevButton.layer.cornerRadius = 2.0;
        prevButton.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1);
        
        nextButton.layer.borderWidth = 1.0;
        nextButton.layer.cornerRadius = 2.0;
        nextButton.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1);
        
        // Do any additional setup after loading the view.
        
        readSavedFlashcards()
        
        if flashcards.count == 0
        {
            updateFlashcard(question: "What is my pick for best open world game?", answer: "Skyrim", extraAnswerOne: "CyberPunk 2077", extraAnswerTwo: "GTA5")
            deleteButton.isEnabled = false
        }
        
        else{
            updateLabels()
            updateNextPrevButtons()
            deleteButton.isEnabled = true
        }
        
     
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
        
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        flashcards.append(flashcard)
        
        print("Added new Flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
      
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)

        updateNextPrevButtons()
        
        updateLabels()
        
    }
    
    
    func updateNextPrevButtons()
    {
        if currentIndex == flashcards.count - 1
        {
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0
        {
            prevButton.isEnabled = false
        }
        else{
            prevButton.isEnabled = true
        }
    }
    
    
    func updateLabels()
    {
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    
    func saveAllFlashcardsToDisk(){
        
        let dictionaryArray = flashcards.map
        {
            (card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
                                             
        
        UserDefaults.standard.set(flashcards, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards()
    {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]
        {
            let savedCards = dictionaryArray.map {
                dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
        
        
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

    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
        
    }
    

    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style:.destructive) { ACTION in
            self.deleteCurrentFlashcard()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { ACTION in
            
            
        }
        present(alert, animated: true)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
     }
    
    func deleteCurrentFlashcard()
    {
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1
        {
            currentIndex = flashcards.count - 1
        }
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
