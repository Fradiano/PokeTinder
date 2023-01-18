//
//  ViewController.swift
//  PokeTinder
//
//  Created by Fradiano Hasani on 18.01.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiService.fetchTenRndmCards { antwort in
            print("#" + (antwort.data.first?.name ?? "keineKarte"))
            let url = URL(string: (antwort.data.first?.images.large)!)
            let data = try! Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.cardView.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func bugBtn(_ sender: Any) {
        ApiService.fetchTenRndmCards { antwort in
            print("#" + (antwort.data.first?.name ?? "keineKarte"))
            let url = URL(string: (antwort.data.first?.images.large)!)
            let data = try! Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.cardView.image = UIImage(data: data)
            }
        }
    }
    
}

