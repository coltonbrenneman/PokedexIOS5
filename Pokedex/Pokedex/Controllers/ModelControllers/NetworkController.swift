//
//  NetworkController.swift
//  Pokedex
//
//  Created by Colton Brenneman on 6/15/23.
//

import Foundation

class NetworkController {
    
    func fetchPokemon(with searchTerm: String, completion: @escaping(Pokemon?) -> Void) {
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2") else { completion(nil) ; return }
        let finalURL = baseURL.appending(path: "/pokemon/\(searchTerm)")
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { pokemonData, _, error in
            if let error {
                print("Ah shit there's an error", error.localizedDescription)
                completion(nil)
            } //End of error
            guard let data = pokemonData else { completion(nil) ; return }
            do {
                guard let topLevelDictionary = try JSONSerialization.jsonObject(with: data) as? [String : Any] else { completion(nil) ; return }
                let pokemon = Pokemon(topLevelDictionary: topLevelDictionary)
                completion(pokemon)
            } catch {
                print("AH fuck there's an error in the DO TRY CATCH", error.localizedDescription)
                completion(nil)
            } //End of DO/TRY/CATCH
        }.resume() //End of dataTask
    } //End of fetchPokemon
    
    func fetchSpriteImage() {
        
        
    } //End of fetchSpriteImage
} //End of class

