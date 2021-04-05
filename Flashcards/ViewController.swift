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
    var extraAnswer1: String
    var extraAnswer2: String
    
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
    
    var tappedOnNext = false
    
    var tappedOnPrev = false
    
    var mySwitch = false
    
    var correctAnswerButton: UIButton!

    
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
            print("In if")
            updateFlashcard(question: "What is my pick for best open world game?", answer: "Skyrim", extraAnswerOne: "CyberPunk 2077", extraAnswerTwo: "GTA5", isExisting: false)
            deleteButton.isEnabled = false
        }
        
        else if flashcards.count == 1
        {
            print(flashcards.count)
            print("In else if")
            updateLabels()
            updateNextPrevButtons()
            deleteButton.isEnabled = false
        }
        
        else{
            print(flashcards.count)
            print("In else")
            updateLabels()
            updateNextPrevButtons()
            deleteButton.isEnabled = true
        }
        
     
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
        })
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        flipFlashcard()
        
    }
    
    
    func flipFlashcard()
    {
       
        if(frontLabel.isHidden == false)
        {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {self.frontLabel.isHidden = true})
//            frontLabel.isHidden = true;
            return;
        }

        else if(frontLabel.isHidden == true)
        {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {self.frontLabel.isHidden = false})
          //  frontLabel.isHidden = false;
            return;
        }
        

    }
    
    
    func animateCardOut()
    {
        
        if(tappedOnNext == true)
        {
            mySwitch = true
            UIView.animate(withDuration: 0.3, animations: { self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0) }, completion: { finished in
                
                self.updateLabels()
                
                self.animateCardIn()
                
            })
        }
        
        else if (tappedOnPrev == true)
        {
            mySwitch = false
            UIView.animate(withDuration: 0.3, animations: { self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0) }, completion: { finished in
                
                self.updateLabels()
                
                self.animateCardIn()
                
            })
        }

    }
    
    func animateCardIn()
    {
        
        if(mySwitch == true)
        {
            card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }
        
        
        else if(mySwitch == false)
        {
            card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }
        
        UIView.animate(withDuration: 0.3)
        {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?, isExisting: Bool) {
        
        let flashcard = Flashcard(question: question, answer: answer, extraAnswer1: extraAnswerOne!, extraAnswer2: extraAnswerTwo!)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
       
        
        if(isExisting)
        {
            flashcards[currentIndex] = flashcard
            print(question)
            
            btnOptionOne.setTitle(extraAnswerOne, for: .normal)
            btnOptionTwo.setTitle(answer, for: .normal)
            btnOptionThree.setTitle(extraAnswerTwo, for: .normal)

            updateNextPrevButtons()
            
            updateLabels()
            
            saveAllFlashcardsToDisk()
        }
        
        else{
            flashcards.append(flashcard)
            
            print("Added new Flashcard")
            print("We now have \(flashcards.count) flashcards")
            
            currentIndex = flashcards.count - 1
            print("Our current index is \(currentIndex)")
            
            print(question)
            
            btnOptionOne.setTitle(extraAnswerOne, for: .normal)
            btnOptionTwo.setTitle(answer, for: .normal)
            btnOptionThree.setTitle(extraAnswerTwo, for: .normal)

            updateNextPrevButtons()
            
            updateLabels()
            
            saveAllFlashcardsToDisk()
        }
      

        
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
        
//        btnOptionOne.setTitle(currentFlashcard.extraAnswer1, for: .normal)
//        btnOptionTwo.setTitle(currentFlashcard.answer, for: .normal)
//        btnOptionThree.setTitle(currentFlashcard.extraAnswer2, for: .normal)
        
        let buttons = [btnOptionOne, btnOptionTwo, btnOptionThree].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.extraAnswer1, currentFlashcard.extraAnswer2].shuffled()
        
        for (button, answer) in zip (buttons, answers)
        {
            button?.setTitle(answer, for: .normal)
            
            if answer == currentFlashcard.answer
            {
                correctAnswerButton = button
            }
        }
        
    }
    
    
    func saveAllFlashcardsToDisk(){
        
        let dictionaryArray = flashcards.map
        {
            (card) -> [String: String] in return ["question": card.question, "answer": card.answer, "extraAnswer1": card.extraAnswer1, "extraAnswer2": card.extraAnswer2]
        }
                                             
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards()
    {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]
        {
            let savedCards = dictionaryArray.map {
                dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswer1: dictionary["extraAnswer1"] ?? "", extraAnswer2: dictionary["extraAnswer2"] ?? "")
            }
            
            flashcards.append(contentsOf: savedCards)
        }
        
        
    }
    @IBAction func didTapOptionOne(_ sender: Any) {
        
        if btnOptionOne == correctAnswerButton
        {
            flipFlashcard()
            btnOptionOne.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)

        }
        
        else{
            frontLabel.isHidden = false
            btnOptionOne.isEnabled = false
            btnOptionOne.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

        }
        
        
        
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        if btnOptionTwo == correctAnswerButton
        {
            flipFlashcard()
            btnOptionTwo.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        
        else{
            frontLabel.isHidden = false
            btnOptionTwo.isEnabled = false
            btnOptionTwo.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        if btnOptionThree == correctAnswerButton
        {
            flipFlashcard()
            btnOptionThree.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        
        else{
            frontLabel.isHidden = false
            btnOptionThree.isEnabled = false
            btnOptionThree.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
    }

    @IBAction func didTapOnPrev(_ sender: Any) {
        
        tappedOnPrev = true
        
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
        
        animateCardOut()
        
        tappedOnPrev = false
    }
    

    @IBAction func didTapOnNext(_ sender: Any) {
       
        tappedOnNext = true
        
        currentIndex = currentIndex + 1
        
        updateLabels()
        
        updateNextPrevButtons()
        
        animateCardOut()
        
        tappedOnNext = false
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
        print("in deleteCurrentFlashcard")
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1
        {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
        updateLabels()
        
        saveAllFlashcardsToDisk()
        
        print(flashcards.count)
        if(flashcards.count > 1) 
        {
            deleteButton.isEnabled = true
        }
        else{
            deleteButton.isEnabled = false
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
