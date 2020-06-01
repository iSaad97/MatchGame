//
//  SondeManger.swift
//  Match App
//
//  Created by saad alessa on 1/6/20.
//  Copyright © 2020 Saad Aleissa. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
   static var audioPlayer:AVAudioPlayer?
    
    
    enum SoundEffect {
        case flip
        case shuffle
        case match
        case nomatch
    }
   static func playSound( _ effect:SoundEffect){
        // which sound effeect to play
        
        // and set the correct name
        var soundFileName = ""
        
        switch effect {
        case .flip:
            soundFileName = "cardflip"
            
        case .shuffle:
            soundFileName = "shuffle"
            
        case .match:
            soundFileName = "dingcorrect"
            
        case .nomatch:
            soundFileName = "dingwrong"
            
            
        }
        
        // get the path to the sound file inside the bundle
        let bundelPath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        
        guard bundelPath != nil else {
            print("couldn't find sound file \(soundFileName) in the bundle ")
            return
        }
        
        // create a URL object from this string path
        
        let soundURL = URL(fileURLWithPath: bundelPath!)
        
        // Create audio player object
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            //Play the sound 
            audioPlayer?.play()
        }  catch {
            // couldn't create audio player ibjcet, log the error
            print("Couldn't create thr audio obecjt for the sound file \(soundFileName)")
        }
    }
    
}
