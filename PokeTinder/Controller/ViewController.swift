//
//  ViewController.swift
//  PokeTinder
//
//  Created by Fradiano Hasani on 18.01.23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var firstCard: CardView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        firstCard.delegate = self
    }

}

extension ViewController: CardViewDelegate{
    func didSelectCard(card: Datum) {
        
    }
    
    func cardGoesRight(card: Datum) {
        var likedPkm = Pokedex(context: appDelegate.persistentContainer.viewContext)
        
        
        
        likedPkm.name = card.name
        likedPkm.image = firstCard.image?.jpegData(compressionQuality: 1.0)
        appDelegate.saveContext()
    }
    
    func cardGoesLeft(card: Datum) {
        
    }
    

    
}
