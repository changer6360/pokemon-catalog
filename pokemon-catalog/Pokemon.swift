//
//  Pokemon.swift
//  pokemon-catalog
//
//  Created by Tihomir Videnov on 6/7/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import Foundation
import Alamofire

//the main pokemon class
class Pokemon {
    
    private var _name: String!
    private var _pokemonID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    private var _moves: String!
    
    var movesArray:[String] = []

    var moves: String {
        if _moves == nil {
            _moves = ""
        }
        return _moves
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defence: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    var name: String {
        return _name
    }
    
    var pokemonID: Int {
        return _pokemonID
    }
    
    init(name: String, pokemonID: Int){
        self._name = name.capitalized
        self._pokemonID = pokemonID
        
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokemonID!)/"
        print(self._pokemonUrl)
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        let url = URL(string: _pokemonUrl)!
        Alamofire.request(url).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                    print(self._defense)
                }
                
                //moves
                if let moves = dict["moves"] as? [Dictionary<String, AnyObject>] , moves.count > 0 {
                    
                    if moves.count > 10 {
                    for x in 0...10 {
                        if let moveArray = moves[x]["name"] as? String {
                            
                            self.movesArray.append(moveArray)
                            let newStr = self.movesArray.joined(separator: ", ")
                            self._moves = newStr
                            }
                        }
                    } else {
                       
                        for x in 0...moves.count - 1 {
                            if let moveArray = moves[x]["name"] as? String {
                                
                            self.movesArray.append(moveArray)
                            let newStr = self.movesArray.joined(separator: ", ")
                            self._moves = newStr
                    }
                        
                }
                        
                    }
                    
                
                //types
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        for x in 1...types.count - 1 {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                                
                                    }
                                }
                            }
                        }
                    
                } else {
                    self._type = ""
                }
                
                //description
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>] , descArray.count > 0  {
                    if let url = descArray[0]["resource_uri"] {
                        let nsurl = "\(URL_BASE)\(url)"
                        Alamofire.request(nsurl).responseJSON { response in
                            
                            let descResult = response.result
                
                            if let descDict = descResult.value as? Dictionary<String, AnyObject> {
                                if let  description = descDict["description"] as? String {
                                    self._description = description.replacingOccurrences(of: "POKMON", with: "pokemon")
                                    
                                }
                            }
                            completed()
                    }
                    
                } else {
                    self._description = ""
                }
            }
                //evolutions
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        //avoiding mega pokemon with purpose
                        if to.range(of: "mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let num = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionID = num
                                self._nextEvolutionText = to
                                
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLvl = "\(lvl)"
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
