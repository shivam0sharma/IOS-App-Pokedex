//
//  Pokemon.swift
//  Pokedex
//
//  Created by Shivam Sharma on 6/20/17.
//  Copyright © 2017 ShivamSharma. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defence: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvolutionText: String!
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId!
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = URL(string: _pokemonUrl)!
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            let result = response.result
            //print(result.debugDescription)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let baseAttack = dict["attack"] as? Int {
                    self._baseAttack = "\(baseAttack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defence = "\(defense)"
                }
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name
                    }
                    if types.count > 1 {
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                print(self._type)
                print(self._defence)
                print(self._baseAttack)
                print(self._weight)
                print(self._height)
            }
        }
    }
}
