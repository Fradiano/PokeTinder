//
//  DetailViewController.swift
//  PokeTinder
//
//  Created by Fradiano Hasani on 26.01.23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var getCard: Pokedex!

    @IBOutlet weak var detailCard: UIImageView!
    
    @IBOutlet weak var detailName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailCard.image = UIImage(data: getCard.image!)
        detailName.text = getCard.name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
