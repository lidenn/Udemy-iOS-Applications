//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var story = Story.init()
    var currentStory = 0
    
    
    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!         // Has TAG = 1
    @IBOutlet weak var bottomButton: UIButton!      // Has TAG = 2
    @IBOutlet weak var storyTextView: UILabel!
    
    // TODO Step 5: Initialise instance variables here
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
    }

    
    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
        // TODO Step 4: Write an IF-Statement to update the views
        if(sender.tag==1){
            currentStory = story.storyBank[currentStory].connectionA
            updateView()
        }
        else{
            currentStory = story.storyBank[currentStory].connectionB
            updateView()
        }
        

        
    }
    
    func updateView(){
        storyTextView.text = story.storyBank[currentStory].story
        
        if(story.storyBank[currentStory].connectionA == -1 || story.storyBank[currentStory].connectionA == -1) {
            self.bottomButton.isHidden = true
            self.topButton.isHidden = true
            var alert = UIAlertController.init(title: "GAME OVER", message: "You have reached the end!", preferredStyle: UIAlertControllerStyle.actionSheet)
            var resetAction = UIAlertAction.init(title: "Restart", style: UIAlertActionStyle.default) { (UIAlertAction) in
                self.reset()
            }
            alert.addAction(resetAction)
            present(alert, animated: true)
        }
        else{
            topButton.setTitle(story.storyBank[currentStory].answerA, for: UIControlState.normal)
            bottomButton.setTitle(story.storyBank[currentStory].answerB, for: UIControlState.normal)
        }
    }
 
    func reset(){
        self.bottomButton.isHidden = false
        self.topButton.isHidden = false
        currentStory = 0
        updateView()
    }
    



}

