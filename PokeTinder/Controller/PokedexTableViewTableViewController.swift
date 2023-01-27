//
//  PokedexTableViewTableViewController.swift
//  PokeTinder
//
//  Created by Fradiano Hasani on 23.01.23.
//

import UIKit

class PokedexTableViewTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var cards = [Pokedex]()
    var selectedCard: Pokedex?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchPkm()
    }
    
    func fetchPkm(){
        do{
            self.cards = try context.fetch(Pokedex.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("ErrorFetch")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = cards[indexPath.row].name
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCard = cards[indexPath.row]
        performSegue(withIdentifier: "detailSeg", sender: tableView.cellForRow(at: indexPath))
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "warumgehtdasnicht"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! DetailViewController
        vc.getCard = selectedCard
    }
    

}
