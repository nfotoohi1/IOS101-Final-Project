//
//  RecipeListViewController.swift
//  Recipe Book
//
//  Created by Nora Fotoohi on 8/6/25.
//

import Foundation
import UIKit

class RecipeListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        refreshRecipes()
    }
    
    @IBAction func tapNewRecipe(_ sender: Any) {
        performSegue(withIdentifier: "CreateSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateSegue" {
            if let composeNavController = segue.destination as? UINavigationController,
               let composeViewController = composeNavController.topViewController as? CreateRecipeViewController {
                
                
                if let recipeToEdit = sender as? Recipe {
                    composeViewController.recipeToEdit = recipeToEdit
                }
                
                
                composeViewController.onComposeRecipe = { [weak self] recipe in
                    recipe.save()
                    self?.refreshRecipes()
                }
            }
        }
    }
    
    private func refreshRecipes() {
        var newRecipes = Recipe.getRecipes()
        self.recipes = newRecipes
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}


extension RecipeListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recipes.remove(at: indexPath.row)
            Recipe.save(recipes)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //self.refreshRecipes()
        }
    }
}


extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let selectedRecipe = recipes[indexPath.row]
        performSegue(withIdentifier: "CreateSegue", sender: selectedRecipe)
    }
}
