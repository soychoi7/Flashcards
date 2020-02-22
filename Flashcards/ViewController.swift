//
//  ViewController.swift
//  Flashcards
//
//  Created by Soyoun Choi on 2/21/20.
//  Copyright © 2020 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden){frontLabel.isHidden = false; backLabel.isHidden = true} else{frontLabel.isHidden = true;  backLabel.isHidden = false}
    }
}

