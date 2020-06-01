//
//  ViewController.swift
//  Match App
//
//  Created by saad alessa on 1/3/20.
//  Copyright © 2020 Saad Aleissa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex: IndexPath?
    var timer:Timer?
    
    
    
    var milliseconds: Float = 30 * 1000 // 10 Second
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        
        // call th getCard method of cardModel
        
        cardArray = model.getCard()
        
        // create a timer
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }
    
    // MARK: - Timer Methods
    @objc func timerElapsed(){
        milliseconds -= 1
        
        // Convert to second
        
        let seconds =   String(format: "%.2f", milliseconds/1000)
        
        
        //set Label
        timerLabel.text = "Time Remaining: \(seconds) "
        
        // when timer has reaach 0
        
        if milliseconds <= 0 {
            // Stop the timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            // Check if there are any cards unmatched
            
            checkGameEnded()
        }
    }
    
    
    
    // MARK: - UICollectionView Porotocol Meethod
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // Gett an CardCollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get the Card that the collection view is trying to display
        let card = cardArray[indexPath.row]
        
        // Ser that card for the cell 
        cell.setCard(card)
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        // Check if there's any tiime left
        
        if milliseconds <= 0 {
            return
        }
        // Get the Cell that the user Selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // Get the card that the user Selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false  {
            
            
            // Flip the Card
            cell.flip()
            
            //Play the flip sound
            
            SoundManager.playSound(.flip)
            // set The status of the card
            card.isFlipped = true
            
            // Determine if it's the first card or second catd thst'd flipped over
            if firstFlippedCardIndex == nil {
                //This is the forst card being flipped
                firstFlippedCardIndex = indexPath
            }
            else {
                // This is the seconde card being flipped
                
                // TODO: prerforn the matching logic
                
                checkForMatches(indexPath)
                
            }
        }
        
        //        else {
        //
        //            // Filp the card Back
        //            cell.flipBack()
        //
        //            // set The status of the card
        //                 card.isFlipped = false
        //
        //        }
        
        
        
        
    } // End of didSelectItem
    
    // MARK: - game Logic Mehods
    
    func checkForMatches (_ secondeFlippedCardIndex: IndexPath){
        //Get the xells for the two cards that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        
        let cardTwoCell = collectionView.cellForItem(at: secondeFlippedCardIndex) as? CardCollectionViewCell
        
        // Get the Cards for the two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondeFlippedCardIndex.row]
        
        // Compare the two Card
        
        if cardOne.imageName == cardTwo.imageName {
            // It's  a match
            
            //Play the sound
            
            SoundManager.playSound(.match)
            // Srt the statuses of the cards
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // remove both cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            // CHeck if there any cards left unmatched
            checkGameEnded()
            
        }
        else {
            // It's not a match
            
            //Play the sound
            SoundManager.playSound(.nomatch)
            
            // Set the statuse of the cards
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // flip boht cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        // Tell the collectionView to reload the cell of the dirst card if it is nil
        
        if cardOneCell == nil {
            
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        // Reset the property that trach the first card flipped
        
        firstFlippedCardIndex = nil
        
    }
    
    
    func checkGameEnded() {
        
        // Determine if there are any cards unmatched
        
        var isWon = true
        
        for card in cardArray {
            if card.isMatched == false{
                isWon = false
                break
            }
        }
        
        // Messaging varibale
        
        var title = ""
        var message = ""
        // if not, then user has won, stop the timer
        if isWon == true{
            
            if milliseconds > 0 {
                timer?.invalidate()
            }
            title = "Congratulations!"
            message = "You've Won"
            
        }
        else{
            
                 // if there are unmached cards, check if there's any time left
            if milliseconds > 0 {
                return
            }
            title = "Game over"
            message = "You Lost Loser "
            
        }
        
   // show won/lost message
        showAlert(title, message)
        

    }
    
    func showAlert (_ title:String , _ message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
            present(alert, animated: true, completion: nil)
        
    }
    
} // ViewController class

