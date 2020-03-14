//
//  ViewController.swift
//  Flashcards
//
//  Created by Soyoun Choi on 2/21/20.
//  Copyright © 2020 CodePath. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    //Current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        readSavedFlashcards()
        
        if flashcards.count == 0{
            updateFlashcard(question: "What is the capital of Florida", answer: "Tallahassee")}else{
            updateLabels()
            updateNextPrevButtons()
    }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden){frontLabel.isHidden = false; backLabel.isHidden = true} else{frontLabel.isHidden = true;  backLabel.isHidden = false}
        
    }
    
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        //Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else{
            nextButton.isEnabled = true
        }
    }
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBAction func didTapOnNext(_sender:Any){
        currentIndex = currentIndex+1
        updateLabels()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_sender:Any){
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    func saveAllFlashcardsToDisk(){
            
            let dictionaryArray = flashcards.map {(card)-> [String: String] in return ["question": card.question, "answer": card.answer]
            }
            
    UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
            print("Flashcards saved to UserDefaults")
        
        }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]{
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func updateFlashcard (question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = question
        backLabel.text = answer
        flashcards.append(flashcard)
        
        //Logging to the console
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        //Update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        updateNextPrevButtons()
        
        //Update labels
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func didTapOnDelete(_sender:Any){
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){action in self.deleteCurrentFlashcard()
            
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count-1{
            currentIndex = flashcards.count-1
        }
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
}

