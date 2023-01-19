//
//  ViewController.swift
//  PokeTinder
//
//  Created by Fradiano Hasani on 18.01.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lastCard: CardView!
    
    @IBOutlet weak var firstCard: CardView!
    
    @IBOutlet weak var secondCard: CardView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiService.fetchTenRndmCards { antwort in
            print("#" + (antwort.data.first?.name ?? "keineKarte"))
            let url = URL(string: (antwort.data[0].images.large))
            let url2 = URL(string: (antwort.data[1].images.large))
            let url3 = URL(string: (antwort.data[2].images.large))
            let data = try! Data(contentsOf: url!)
            let data1 = try! Data(contentsOf: url2!)
            let data2 = try! Data(contentsOf: url3!)
            DispatchQueue.main.async {
                self.firstCard.image = UIImage(data: data)
                self.firstCard.cardSaver = antwort.data[0]
                self.secondCard.image = UIImage(data: data1)
                self.secondCard.cardSaver = antwort.data[1]
                self.lastCard.image = UIImage(data: data2)
                self.lastCard.cardSaver = antwort.data[2]
            }
        }
    }
    
    @IBAction func bugBtn(_ sender: Any) {
        ApiService.fetchTenRndmCards { antwort in
            print("#" + (antwort.data.first?.name ?? "keineKarte"))
            let url = URL(string: (antwort.data.first?.images.large)!)
            let data = try! Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.firstCard.image = UIImage(data: data)
            }
        }
    }
    
}

