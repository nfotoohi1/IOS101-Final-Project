//
//  Recipe.swift
//  Recipe Book
//
//  Created by Nora Fotoohi on 8/7/25.
//

import Foundation
let defaults = UserDefaults.standard

struct Recipe: Codable {
    var name: String
    var ingredients: String
    var instructions: String
    
    init(name: String, ingredients: String, instructions: String) {
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
    }
    private(set) var id: String = UUID().uuidString
}

extension Recipe {

    static func save(_ recipes: [Recipe]) {
        let encoded = try! JSONEncoder().encode(recipes)
        defaults.set(encoded, forKey: "recipes")
    }

    static func getRecipes() -> [Recipe] {
        if let encoded = defaults.data(forKey: "recipes"){
            let decoded = try! JSONDecoder().decode([Recipe].self, from: encoded)
            return decoded // 👈 replace with returned saved tasks
        }
        else {
            return []
        }
    }

    func save() {
        var recipes = Recipe.getRecipes()
        for (index, recipe) in recipes.enumerated() {
            if self.id == recipe.id {
                recipes.remove(at: index)
                recipes.insert(self, at: index)
                Recipe.save(recipes)
                return
            }
        }
        recipes.append(self)
        Recipe.save(recipes)
    }
}
