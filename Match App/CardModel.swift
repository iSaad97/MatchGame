//
//  CardModel.swift
//  Match App
//
//  Created by saad alessa on 1/3/20.
//  Copyright © 2020 Saad Aleissa. All rights reserved.
//

import Foundation


class CardModel  {
    
    func getCard() -> [Card] {
        
        //Declae an array to store number we've a;ready generated
        var generatedNumbersArray = [Int]()
        
        // Declare an array to store the generated card
        var generatedCardsArray = [Card]()
        
        
        // Randomly Generate pairs of card
        while generatedNumbersArray.count < 8  {
            
            let randomNumber = arc4random_uniform(13) + 1
            
            // Ensure that the random number is'nt one we have
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                
                // Log the number
                
                print(randomNumber)
                
                // Store the number into the generatedNumbersArray
                
                generatedNumbersArray.append(Int(randomNumber))
                
                // Create the first card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                generatedCardsArray
                    .append(cardOne)
                
                // create the 2nd card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardTwo)
            }
            
            
            
            
            
        }
        
        //  Randomize the array
        for i in 0...generatedCardsArray.count-1 {
            //Find a random index to swap
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
           
            // Swap two Cards
            let tempStorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = tempStorage
        }
        //Return the array
        
        return generatedCardsArray
        
        
        
    }
    
    
}
