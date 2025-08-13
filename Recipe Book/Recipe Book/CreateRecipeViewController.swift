//
//  CreateRecipeViewController.swift
//  Recipe Book
//
//  Created by Nora Fotoohi on 8/7/25.
//

import Foundation
import UIKit

class CreateRecipeViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ingredientsField: UITextField!
    @IBOutlet weak var instructionsField: UITextField!
    
    var onComposeRecipe: ((Recipe) -> Void)? = nil
    
    var recipeToEdit: Recipe? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let recipeToEdit = recipeToEdit {
            nameField.text = recipeToEdit.name
            ingredientsField.text = recipeToEdit.ingredients
            instructionsField.text = recipeToEdit.instructions
        }
    }
    
    @IBAction func tapDone(_ sender: Any) {
        guard let name = nameField.text,
              !name.isEmpty
        else {
            presentAlert(title: "Oops...", message: "Make sure to add a recipe name!")
            return
        }
        guard let ingredients = ingredientsField.text,
              !ingredients.isEmpty
        else {
            presentAlert(title: "Oops...", message: "Make sure to add a list of ingredients!")
            return
        }
        guard let instructions = instructionsField.text,
              !instructions.isEmpty
        else {
            presentAlert(title: "Oops...", message: "Make sure to add instructions!")
            return
        }
        
        var recipe: Recipe
        if var existingRecipe = recipeToEdit {
            existingRecipe.name = name
            existingRecipe.ingredients = ingredients
            existingRecipe.instructions = instructions
            recipe = existingRecipe
        } else {
            recipe = Recipe(name: name, ingredients: ingredients, instructions: instructions)
        }
        
        onComposeRecipe?(recipe)
        dismiss(animated: true)
    }
    
    @IBAction func tapCancel(_ sender: Any) {
        dismiss(animated: true)
    }

    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
