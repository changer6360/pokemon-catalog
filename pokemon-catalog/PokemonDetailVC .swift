//
//  PokekonDetailVC.swift
//  pokemon-catalog
//
//  Created by Tihomir Videnov on 6/12/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class PokekonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
 
    var preCheck: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameLbl.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokemonID)")
        mainImg.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
            
        }
    
    
    func updateUI(){
        if preCheck == false {
        descriptionLbl.text = pokemon.description
        } else {
            descriptionLbl.text = "\(pokemon.moves)"
        }
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defence
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        pokedexLbl.text = "\(pokemon.pokemonID)"
        attackLbl.text = pokemon.attack
        
        if pokemon.nextEvolutionID == "" {
            evoLbl.text = "No evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionID)
            var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
                evoLbl.text = "\(str)"
            }
        }
        
    }

    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentedController(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            preCheck = false
            updateUI()
        } else {
            preCheck = true
            updateUI()
        }
    }
    

}
