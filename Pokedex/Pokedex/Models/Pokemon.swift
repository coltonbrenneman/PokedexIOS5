//
//  Pokemon.swift
//  Pokedex
//
//  Created by Colton Brenneman on 6/15/23.
//

import Foundation

class Pokemon {
    
    let name: String
    let id: Int
    let moves: [String] //This is my goal, not what the api shows
    let spritePath: String
    let height: Int
    
    init(name: String, id: Int, moves: [String], spritePath: String, height: Int) {
        self.name = name
        self.id = id
        self.moves = moves
        self.spritePath = spritePath
        self.height = height
    }
} //End of class

// MARK: - Extensions
extension Pokemon {
    
    convenience init?(topLevelDictionary: [String : Any]) {
        guard let name = topLevelDictionary["name"] as? String,
              let id = topLevelDictionary["id"] as? Int,
              let height = topLevelDictionary["height"] as? Int,
              let spriteDict = topLevelDictionary["sprites"] as? [String : Any],
                    let spritePath = spriteDict["front_shiny"] as? String, // spritePath is in the spriteDict 
              let movesArray = topLevelDictionary["moves"] as? [[String : Any]] else { return nil }
     
        var tempMoves: [String] = []
        for moves in movesArray {
            guard let movieDict = moves["move"] as? [String : Any],
                  let name = movieDict["name"] as? String else { return nil }
            tempMoves.append(name)
        }
        
        
        self.init(name: name, id: id, moves: tempMoves, spritePath: spritePath, height: height)
    }
} //End of extension
// We don't need a for in loop for sprites since it's not an array
