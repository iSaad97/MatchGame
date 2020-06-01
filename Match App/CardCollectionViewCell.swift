//
//  CardCollectionViewCell.swift
//  Match App
//
//  Created by saad alessa on 1/4/20.
//  Copyright © 2020 Saad Aleissa. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card){
        
        // Keep track of the card that gets passed in
        self.card = card
        
        
        if card.isMatched == true {
            
            // if the card matches make the card invisibale
            
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        } else {
            
            // if the card is not matched make the view visible 
            backImageView.alpha = 1
                   frontImageView.alpha = 1
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //Determine if the card is in a flipped up states or fllipped down satate
        
        if card.isFlipped == true {
            // Make sure the frontimiageView is on top
            
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion: nil)
            
        }
        else{
            // Make sure the backimageView is on top
            
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
        
    }
    
    func flip(){
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews],
                          completion: nil)
        
    }
    
    func flipBack(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews],
                                  completion: nil)
            
                }

            
        
    }
    
    func remove(){
        
        // Remove both imageViews from ein Visible
        backImageView.alpha = 0

        //  Animate it
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)

        
    }
    
}
