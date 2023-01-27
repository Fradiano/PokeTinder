//
//  ProfilViewController.swift
//  PokeTinder
//
//  Created by Fradiano Hasani on 26.01.23.
//

import UIKit

class ProfilViewController: UIViewController {

    
    @IBOutlet weak var profilImg: UIImageView!
    
    @IBOutlet weak var favCard: UIImageView!
    
    var fav = [Pokedex]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilImg.layer.cornerRadius = 77
        
    }
    


}
