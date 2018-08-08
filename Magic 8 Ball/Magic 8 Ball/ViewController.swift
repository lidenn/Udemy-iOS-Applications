//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Dennis Li on 7/21/18.
//  Copyright © 2018 Dennis Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var ballArray = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    @IBOutlet weak var ballImage: UIImageView!
    @IBAction func askButton(_ sender: Any) {
        changeBallValue();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ballImage.image = UIImage(named: "ball1")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func changeBallValue(){
        let num = Int(arc4random_uniform(5));
        print(num)
        ballImage.image = UIImage(named: ballArray[num])
        
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?){
        if (motion == .motionShake){
            changeBallValue()
        }
        

    }

}

