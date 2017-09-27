//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Remi Tobias on 18/09/2017.
//  Copyright © 2017 Remi Tobias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //startAdventure
        if segue.identifier == "startAdventure" {
            guard let pageController = segue.destination as? PageController else{
                return
            }
            pageController.page = Adventure.story
        }
    }


}

