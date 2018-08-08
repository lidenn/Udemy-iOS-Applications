//
//  Option.swift
//  Destini
//
//  Created by Dennis Li on 7/31/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Option{
    var story = "Story"
    var answerA = "A"
    var answerB = "B"
    var connectionA = -1
    var connectionB = -1
    
    
    init(newStory : String, newAnswerA : String, newAnswerB : String , newConnectionA : Int, newConnectionB : Int){
        story = newStory
        answerA = newAnswerA
        answerB = newAnswerB
        connectionA = newConnectionA
        connectionB = newConnectionB
    }
    
    init(newStory : String){
        story = newStory
        answerA = ""
        answerB = ""
        connectionA = -1
        connectionB = -1
    }
}
