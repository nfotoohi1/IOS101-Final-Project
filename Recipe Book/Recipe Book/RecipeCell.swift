//
//  RecipeCell.swift
//  Recipe Book
//
//  Created by Nora Fotoohi on 8/11/25.
//

import Foundation
import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    var recipe: Recipe!
    
    func configure(with recipe: Recipe) {
        self.recipe = recipe
        update(with: recipe)
    }
    
    private func update(with recipe: Recipe) {
        recipeName.text = recipe.name
    }
    
    
    
    
}
