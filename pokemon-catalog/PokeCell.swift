//
//  PokeCell.swift
//  pokemon-catalog
//
//  Created by Tihomir Videnov on 6/8/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

//custom collection view cell
class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!

    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(_ pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokemonID)")
        
        
    }
    
}
