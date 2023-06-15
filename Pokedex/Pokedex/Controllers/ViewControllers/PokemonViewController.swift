//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Karl Pfister on 2/3/22.
//

import UIKit

class PokemonViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    // MARK: - Properties
    var pokemon: Pokemon?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonMovesTableView.dataSource = self
        pokemonSearchBar.delegate = self
    }
    
    // MARK: - Fucntions
    func updateUI(with image: UIImage) {
        guard let pokemon = pokemon else { return }
        DispatchQueue.main.async {
            self.pokemonMovesTableView.reloadData()
            self.pokemonIDLabel.text = "ID: \(pokemon.id)"
            self.pokemonNameLabel.text = pokemon.name
            self.pokemonSpriteImageView.image = image
        }
    }
} // End of class

// MARK: - Extensions
extension PokemonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon?.moves.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        cell.textLabel?.text = pokemon?.moves[indexPath.row]
        
        return cell
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkController().fetchPokemon(with: searchText) { pokemon in
            guard let pokemon = pokemon else { return }
            self.pokemon = pokemon
            NetworkController().fetchSpriteImage(pokemon: pokemon) { image in
                guard let image = image else { return }
                self.updateUI(with: image)
            } //End of spriteImage
        } //End of fetchPokemon
    } //End of func searchBar
} //End of extension
 
