//
//  ConcentrationThemeChooser.swift
//  Concentration
//
//  Created by Carolina Salamanca on 7/20/20.
//  Copyright © 2020 Carolina Salamanca. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // dictionary
    let themes = [
        "Sports": "🤼🏋️‍♂️⛷🏌️‍♂️⛹️‍♀️🤸‍♂️",
        "Animals": "🐶🐱🐭🐹🐰🐻",
        "Faces": "😀🤑😎🤓😁😫"
    ]
    
    private var lastSeguedToConcentrationtViewController: ConcentrationViewController?
    
    @IBAction func chooseTheme(_ sender: Any) {
        if let cvc = lastSeguedToConcentrationtViewController{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else{
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    // MARK: - Navigation
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "Choose Theme"{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                if let cvc = segue.destination as? ConcentrationViewController{
                    cvc.theme = theme
                    lastSeguedToConcentrationtViewController = cvc
                }
            }
        }
    }
    
    
}

