//
//  IngredientManager.swift
//  CKJY V2
//
//  Created by RGS on 21/11/23.
//

import Foundation
import SwiftUI

class IngredientManager: ObservableObject {
    
    // MARK: Selected Ingredients
    
    @Published var selectedIngredients: [Ingredient] = [] {
        didSet {
            save()
        }
    }
    @Published var selectedIngredientsSearchTerm = ""

    var selectedIngredientsFilteredHealthy: Binding<[Ingredient]> {
        Binding (
            get: {
                if self.selectedIngredientsSearchTerm == "" {
                    return self.selectedIngredients.filter {
                        $0.points == 1
                    }
                }
                return self.selectedIngredients.filter {
                    $0.name.lowercased().contains(self.selectedIngredientsSearchTerm.lowercased()) && $0.points == 1
                }
            },
            set: {
                self.selectedIngredients = $0
            }
        )
    }
    
    var selectedIngredientsFilteredNeutral: Binding<[Ingredient]> {
        Binding (
            get: {
                if self.selectedIngredientsSearchTerm == "" {
                    return self.selectedIngredients.filter {
                        $0.points == 0
                    }
                }
                return self.selectedIngredients.filter {
                    $0.name.lowercased().contains(self.selectedIngredientsSearchTerm.lowercased()) && $0.points == 0
                }
            },
            set: {
                self.selectedIngredients = $0
            }
        )
    }
    
    var selectedIngredientsFilteredUnhealthy: Binding<[Ingredient]> {
        Binding (
            get: {
                if self.selectedIngredientsSearchTerm == "" {
                    return self.selectedIngredients.filter {
                        $0.points == -1
                    }
                }
                return self.selectedIngredients.filter {
                    $0.name.lowercased().contains(self.selectedIngredientsSearchTerm.lowercased()) && $0.points == -1
                }
            },
            set: {
                self.selectedIngredients = $0
            }
        )
    }
    
    // MARK: Total Points
    
    @Published var totalPoints = 0
    {
        didSet {
            save()
        }
    }
    
    // MARK: Points Goal
    
    @Published var pointsGoal = 30
    {
        didSet {
            save()
        }
    }
    
    // MARK: Recipes
    
    @Published var recipes: [Recipe] = [] {
        didSet {
            save()
        }
    }

    @Published var recipesSearchTerm = ""

    var recipesFiltered: Binding<[Recipe]> {
        Binding (
            get: {
                if self.recipesSearchTerm == "" { return self.recipes }
                return self.recipes.filter {
                    $0.recipeTitle.lowercased().contains(self.recipesSearchTerm.lowercased())
                }
            },
            set: {
                self.recipes = $0
            }
        )
    }

    // MARK: Recipe Ingredients
    
    @Published var recipeIngredients: [RecipeIngredient] = [
        ] {
        didSet {
            save()
        }
    }

    @Published var searchTerm2 = ""

    var recipesIngredientsFiltered: Binding<[RecipeIngredient]> {
        Binding (
            get: {
                if self.searchTerm2 == "" { return self.recipeIngredients }
                return self.recipeIngredients.filter {
                    $0.ingredient.name.lowercased().contains(self.searchTerm2.lowercased())
                }
            },
            set: {
                self.recipeIngredients = $0
            }
        )
    }
    
    // MARK: Preset Ingredients

    @Published var presetIngredients: [Ingredient] = [
        Ingredient(name: "Zucchini", points: 1),
        Ingredient(name: "Yellow squash", points: 0),
        Ingredient(name: "Yellow onion", points: 0),
        Ingredient(name: "Yellow mustard", points: 0),
        Ingredient(name: "Worcestershire sauce", points: 0),
        Ingredient(name: "Whole wheat pasta ", points: 0),
        Ingredient(name: "Whole wheat flour", points: 1),
        Ingredient(name: "Whole wheat bread", points: 0),
        Ingredient(name: "Whole grain cereal", points: 0),
        Ingredient(name: "White wine vinegar ", points: 0),
        Ingredient(name: "White wine", points: 0),
        Ingredient(name: "White vinegar", points: 0),
        Ingredient(name: "White sugar", points: 0),
        Ingredient(name: "White rice", points: 0),
        Ingredient(name: "White potato", points: 0),
        Ingredient(name: "White pepper", points: 0),
        Ingredient(name: "White onion", points: 0),
        Ingredient(name: "White mushroom", points: 0),
        Ingredient(name: "White chocolate chip", points: 0),
        Ingredient(name: "White chocolate", points: 0),
        Ingredient(name: "White cheddar cheese", points: 0),
        Ingredient(name: "Bread", points: 0),
        Ingredient(name: "White bean", points: 0),
        Ingredient(name: "White balsamic vinegar", points: 1),
        Ingredient(name: "Wheat thin", points: 0),
        Ingredient(name: "Wheat flour", points: 0),
        Ingredient(name: "Watermelon radish", points: 1),
        Ingredient(name: "Watermelon", points: 1),
        Ingredient(name: "Watercress", points: 1),
        Ingredient(name: "Wasabi", points: 1),
        Ingredient(name: "Walnut", points: 0),
        Ingredient(name: "Vanilla extract", points: 0),
        Ingredient(name: "Vanilla", points: 1),
        Ingredient(name: "Udon noodle", points: 1),
        Ingredient(name: "Twizzler", points: 0),
        Ingredient(name: "Twix", points: 0),
        Ingredient(name: "Turnip", points: 1),
        Ingredient(name: "Turmeric root", points: 1),
        Ingredient(name: "Turmeric powder", points: 1),
        Ingredient(name: "Turmeric", points: 1),
        Ingredient(name: "Turkey sausage", points: 0),
        Ingredient(name: "Turkey burger", points: 0),
        Ingredient(name: "Turkey Breast", points: 0),
        Ingredient(name: "Turkey bacon", points: 0),
        Ingredient(name: "Tuna", points: 1),
        Ingredient(name: "Truffle oil", points: 1),
        Ingredient(name: "Triscuit", points: 0),
        Ingredient(name: "Tortilla chip", points: -1),
        Ingredient(name: "Tomato sauce", points: 0),
        Ingredient(name: "Tomato paste", points: 0),
        Ingredient(name: "Tomato", points:1),
        Ingredient(name: "Tomatillo", points: 1),
        Ingredient(name: "Tofu", points: 1),
        Ingredient(name: "Toffee", points: -1),
        Ingredient(name: "Tilapia", points: 0),
        Ingredient(name: "Teriyaki sauce", points: 0),
        Ingredient(name: "Tempeh", points: 1),
        Ingredient(name: "Teddy Graham", points: 0),
        Ingredient(name: "TarTar sauce", points: -1),
        Ingredient(name: "Tarragon", points: 1),
        Ingredient(name: "Tapioca pudding", points: 0),
        Ingredient(name: "Tangelo", points: 1),
        Ingredient(name: "Taco", points: -1),
        Ingredient(name: "Swiss chard", points: 1),
        Ingredient(name: "Sweetened sunflower milk", points: -1),
        Ingredient(name: "Sweetened soy milk", points: -1),
        Ingredient(name: "Sweetened rice milk", points: -1),
        Ingredient(name: "Sweetened oat milk", points: -1),
        Ingredient(name: "Sweetened hemp milk", points: -1),
        Ingredient(name: "Sweetened condensed milk", points: -1),
        Ingredient(name: "Sweetened coconut milk", points: -1),
        Ingredient(name: "Sweetened cashew milk", points: -1),
        Ingredient(name: "Sweetened almond milk", points: -1),
        Ingredient(name: "Sweet potato fries", points: -1),
        Ingredient(name: "Sweet potato", points: 1),
        Ingredient(name: "Sweet pepper", points: 0),
        Ingredient(name: "Sweet onion", points: 1),
        Ingredient(name: "Sweet corn", points: 0),
        Ingredient(name: "Swedish fish", points: 0),
        Ingredient(name: "Sunflower seed", points: 1),
        Ingredient(name: "Sunflower oil", points: 0),
        Ingredient(name: "Sun-dried tomato", points: 1),
        Ingredient(name: "Sunchoke", points: 1),
        Ingredient(name: "Sucralose", points: -1),
        Ingredient(name: "Strawberry", points: 1),
        Ingredient(name: "Star fruit", points: 1),
        Ingredient(name: "Starburst", points: 0),
        Ingredient(name: "Star anise", points: 1),
        Ingredient(name: "Spinach", points: 1),
        Ingredient(name: "Spaghetti", points: 0),
        Ingredient(name: "Soy sauce", points: 0),
        Ingredient(name: "Soy milk", points: 0),
        Ingredient(name: "Soursop", points: 1),
        Ingredient(name: "Sour Patch Kids", points: 0),
        Ingredient(name: "Sourdough bread", points: 0),
        Ingredient(name: "Sour cream", points: 0),
        Ingredient(name: "Sorrel", points: 1),
        Ingredient(name: "Sorghum", points: 1),
        Ingredient(name: "Sodium benzoate", points: -1),
        Ingredient(name: "Sodium Aluminium Sulfate", points: -1),
        Ingredient(name: "Soda", points: -1),
        Ingredient(name: "Soba noodle", points: 1),
        Ingredient(name: "Snickers", points: 0),
        Ingredient(name: "Skittles", points: 0),
        Ingredient(name: "Shrimp", points: 0),
        Ingredient(name: "Shallot", points: 1),
        Ingredient(name: "Sesame seed", points: 1),
        Ingredient(name: "Sesame oil", points: 1),
        Ingredient(name: "Seaweed", points: 1),
        Ingredient(name: "Scallion", points: 0),
        Ingredient(name: "Sausage roll", points: 0),
        Ingredient(name: "Sausage", points: 0),
        Ingredient(name: "Sardine", points: 1),
        Ingredient(name: "Saltine", points: 0),
        Ingredient(name: "Salsify", points: 1),
        Ingredient(name: "Salmon", points: 1),
        Ingredient(name: "Sage", points: 1),
        Ingredient(name: "Saffron", points: 1),
        Ingredient(name: "Saccharin", points: -1),
        Ingredient(name: "Rutabaga", points: 1),
        Ingredient(name: "Romanesco", points: 1),
        Ingredient(name: "Romaine lettuce", points: 1),
        Ingredient(name: "Ritz crackers", points: 0),
        Ingredient(name: "Ricotta cheese", points: 0),
        Ingredient(name: "Rice vinegar", points: 0),
        Ingredient(name: "Rice pudding", points: 0),
        Ingredient(name: "Rice noodles", points: 0),
        Ingredient(name: "Rice Krispie treat", points: 0),
        Ingredient(name: "Rice Krispie", points: 0),
        Ingredient(name: "Rice flour", points: 0),
        Ingredient(name: "Rice cereal", points: 0),
        Ingredient(name: "Rice cakes", points: 0),
        Ingredient(name: "Rice bran oil", points: 1),
        Ingredient(name: "Reese’s Pieces", points: 0),
        Ingredient(name: "Red wine vinegar", points: 0),
        Ingredient(name: "Red wine", points: 0),
        Ingredient(name: "Red snapper", points: 1),
        Ingredient(name: "Red quinoa", points: 1),
        Ingredient(name: "Red potatoes", points: 0),
        Ingredient(name: "Red pepper flake", points: 0),
        Ingredient(name: "Red pepper", points: 1),
        Ingredient(name: "Red lentil", points: 1),
        Ingredient(name: "Red cabbage", points: 1),
        Ingredient(name: "Red bell pepper", points: 0),
        Ingredient(name: "Raspberry vinegar", points: 0),
        Ingredient(name: "Raspberry jam", points: 0),
        Ingredient(name: "Raspberries", points: 1),
        Ingredient(name: "Ranch dressing", points: 0),
        Ingredient(name: "Ramen noodles", points: 0),
        Ingredient(name: "Raisin bran", points: 0),
        Ingredient(name: "Raisins", points: 0),
        Ingredient(name: "Radishes", points: 1),
        Ingredient(name: "Radicchio", points: 0),
        Ingredient(name: "Quinoa", points: 1),
        Ingredient(name: "Quince", points: 1),
        Ingredient(name: "Quark cheese", points: 1),
        Ingredient(name: "Quail eggs", points: 1),
        Ingredient(name: "Pumpkin seed", points: 1),
        Ingredient(name: "Pumpkin oil", points: 1),
        Ingredient(name: "Pumpkin", points: 1),
        Ingredient(name: "Pudding cup", points: 0),
        Ingredient(name: "Prune", points: 1),
        Ingredient(name: "Processed cheese", points: -1),
        Ingredient(name: "Pringle", points: 0),
        Ingredient(name: "Pretzel", points: 0),
        Ingredient(name: "Potato skin", points: 0),
        Ingredient(name: "Potato salad", points: 0),
        Ingredient(name: "Potato chip", points: -1),
        Ingredient(name: "Potato", points: 1),
        Ingredient(name: "Potassium sorbate", points: -1),
        Ingredient(name: "Pork tenderloin", points: 0),
        Ingredient(name: "Pork rib", points: 0),
        Ingredient(name: "Pork chop", points: 0),
        Ingredient(name: "Pop tart", points: -1),
        Ingredient(name: "Popcorn", points: 0),
        Ingredient(name: "Pomegranate seed", points: 1),
        Ingredient(name: "Pomegranate molasses", points: 1),
        Ingredient(name: "Plum", points: 1),
        Ingredient(name: "Plantain", points: 1),
        Ingredient(name: "Plain flour", points: 0),
        Ingredient(name: "Pizza roll", points: 0),
        Ingredient(name: "Pizza", points: -1),
        Ingredient(name: "Pistachio oil", points: 1),
        Ingredient(name: "Pistachio", points: 1),
        Ingredient(name: "Pinto beans", points: 1),
        Ingredient(name: "Pink grapefruit", points: 1),
        Ingredient(name: "Pine nut", points: 1),
        Ingredient(name: "Pineapple juice", points: 0),
        Ingredient(name: "Pineapple", points: 1),
        Ingredient(name: "Pies", points: -1),
        Ingredient(name: "Persimmon", points: 1),
        Ingredient(name: "Pecan pie", points: 0),
        Ingredient(name: "Pecans", points: 1),
        Ingredient(name: "Pears", points: 1),
        Ingredient(name: "Peas", points: 1),
        Ingredient(name: "Pasta", points: 0),
        Ingredient(name: "Passion fruit", points: 1),
        Ingredient(name: "Parsley", points: 0),
        Ingredient(name: "Parmesan cheese", points: 0),
        Ingredient(name: "Paprika", points: 1),
        Ingredient(name: "Pappardelle", points: 1),
        Ingredient(name: "Papaya", points: 1),
        Ingredient(name: "Pancake syrup", points: -1),
        Ingredient(name: "Palm oil", points: -1),
        Ingredient(name: "Oregano", points: 0),
        Ingredient(name: "Orange juice", points: 1),
        Ingredient(name: "Oranges", points: 1),
        Ingredient(name: "Onion powder", points: 0),
        Ingredient(name: "Onions", points: 1),
        Ingredient(name: "Olive oil", points: 1),
        Ingredient(name: "Olestra", points: -1),
        Ingredient(name: "Okra", points: 1),
        Ingredient(name: "Oats", points: 1),
        Ingredient(name: "Nutritional yeast", points: 1),
        Ingredient(name: "Nutmeg", points: 0),
        Ingredient(name: "Nutella", points: 0),
        Ingredient(name: "Nori", points: 1),
        Ingredient(name: "Navy beans", points: 1),
        Ingredient(name: "Napa cabbage", points: 1),
        Ingredient(name: "M&M’s", points: 0),
        Ingredient(name: "Mustard green", points: 1),
        Ingredient(name: "Mustard", points: 0),
        Ingredient(name: "Mushroom", points: 1),
        Ingredient(name: "Mung bean", points: 1),
        Ingredient(name: "Mulberry", points: 1),
        Ingredient(name: "Mozzarella stick", points: -1),
        Ingredient(name: "Mozzarella cheese", points: 0),
        Ingredient(name: "Miso", points: 1),
        Ingredient(name: "Millet", points: 1),
        Ingredient(name: "Milky Way", points: 0),
        Ingredient(name: "Milkshakes", points: -1),
        Ingredient(name: "Mayonnaise", points: -1),
        Ingredient(name: "Marshmallow fluff", points: 0),
        Ingredient(name: "Marshmallows", points: 0),
        Ingredient(name: "Margarine", points: -1),
        Ingredient(name: "Maple syrup", points: 0),
        Ingredient(name: "Mango", points: 1),
        Ingredient(name: "Mache", points: 1),
        Ingredient(name: "Lychee", points: 1),
        Ingredient(name: "Lucky Charms", points: 0),
        Ingredient(name: "Loquat", points: 1),
        Ingredient(name: "Limes", points: 1),
        Ingredient(name: "Licorice", points: -1),
        Ingredient(name: "Lettuce", points: 0),
        Ingredient(name: "Lentil", points: 1),
        Ingredient(name: "Lemongrass", points: 1),
        Ingredient(name: "Lemonade with added sugar", points: -1),
        Ingredient(name: "Lemonade", points: 0),
        Ingredient(name: "Leek", points: 1),
        Ingredient(name: "Lavender", points: 1),
        Ingredient(name: "Lard", points: -1),
        Ingredient(name: "Kohlrabi", points: 1),
        Ingredient(name: "Kix cereal", points: 0),
        Ingredient(name: "Kiwi berries", points: 1),
        Ingredient(name: "Kiwi", points: 1),
        Ingredient(name: "Kit Kat", points: 0),
        Ingredient(name: "Kidney beans", points: 1),
        Ingredient(name: "Ketchup", points: 0),
        Ingredient(name: "Kelp", points: 1),
        Ingredient(name: "Kamut", points: 1),
        Ingredient(name: "Kale", points: 1),
        Ingredient(name: "Jicama", points: 1),
        Ingredient(name: "Jelly beans", points: -1),
        Ingredient(name: "Jasmine rice", points: 0),
        Ingredient(name: "Jams", points: 0),
        Ingredient(name: "Jalapeno", points: 1),
        Ingredient(name: "Jaggery", points: 1),
        Ingredient(name: "Instant rice with seasoning", points: -1),
        Ingredient(name: "Instant ramen noodles", points: -1),
        Ingredient(name: "Instant noodles", points: -1),
        Ingredient(name: "Instant mashed potato flake", points: -1),
        Ingredient(name: "Instant mashed potato", points: -1),
        Ingredient(name: "Instant gravy mix", points: -1),
        Ingredient(name: "Iced teas with added sugar", points: -1),
        Ingredient(name: "Ice cream cone", points: 0),
        Ingredient(name: "Ice cream", points: -1),
        Ingredient(name: "Iceberg lettuce", points: 0),
        Ingredient(name: "Hydrogenated oil", points: -1),
        Ingredient(name: "Huckleberry", points: 1),
        Ingredient(name: "Hot sauce", points: 0),
        Ingredient(name: "Hot dog", points: -1),
        Ingredient(name: "Horseradish", points: 0),
        Ingredient(name: "Honeydew melon", points: 1),
        Ingredient(name: "Honeycomb cereal", points: 0),
        Ingredient(name: "Honey Bunches of Oats", points: 0),
        Ingredient(name: "Honey", points: 0),
        Ingredient(name: "Hershey", points: 0),
        Ingredient(name: "Herring", points: 1),
        Ingredient(name: "Hemp seed", points: 1),
        Ingredient(name: "Hearts of palm", points: 1),
        Ingredient(name: "Hazelnut oil", points: 1),
        Ingredient(name: "Hazelnuts", points: 1),
        Ingredient(name: "Hash browns with added preservatives", points: -1),
        Ingredient(name: "Hard candy", points: -1),
        Ingredient(name: "Hamburger Helper", points: -1),
        Ingredient(name: "Gummy worm", points: 0),
        Ingredient(name: "Gummy candy", points: -1),
        Ingredient(name: "Gummy bear", points: 0),
        Ingredient(name: "Guava", points: 1),
        Ingredient(name: "Ground venison", points: 0),
        Ingredient(name: "Ground veal", points: 0),
        Ingredient(name: "Ground turkey", points: 0),
        Ingredient(name: "Ground rabbit", points: 0),
        Ingredient(name: "Ground pork", points: 0),
        Ingredient(name: "Ground ostrich", points: 0),
        Ingredient(name: "Ground lamb", points: 0),
        Ingredient(name: "Ground chicken", points: 0),
        Ingredient(name: "Ground buffalo", points: 0),
        Ingredient(name: "Ground bison", points: 0),
        Ingredient(name: "Ground beef", points: 0),
        Ingredient(name: "Green tea", points: 1),
        Ingredient(name: "Green peas", points: 1),
        Ingredient(name: "Green onions", points: 1),
        Ingredient(name: "Green olives", points: 0),
        Ingredient(name: "Green lentils", points: 0),
        Ingredient(name: "Green cabbage", points: 0),
        Ingredient(name: "Green bell pepper", points: 1),
        Ingredient(name: "Green bean", points: 1),
        Ingredient(name: "Green yogurt", points: 1),
        Ingredient(name: "Green olive", points: 1),
        Ingredient(name: "Grape juice", points: 0),
        Ingredient(name: "Grapefruit", points: 1),
        Ingredient(name: "Granola", points: 0),
        Ingredient(name: "Graham cracker", points: 0),
        Ingredient(name: "Gouda cheese", points: 0),
        Ingredient(name: "Goldfish cracker", points: 0),
        Ingredient(name: "Gingersnaps", points: 0),
        Ingredient(name: "Ginger", points: 1),
        Ingredient(name: "Ghee", points: 1),
        Ingredient(name: "Garlic powder", points: 0),
        Ingredient(name: "Garlic", points: 0),
        Ingredient(name: "Garam masala", points: 1),
        Ingredient(name: "Fudges", points: -1),
        Ingredient(name: "Fruit snack", points: 0),
        Ingredient(name: "Fruit roll-up", points: -1),
        Ingredient(name: "Fruit loop", points: 0),
        Ingredient(name: "Fruit-flavored snack", points: -1),
        Ingredient(name: "Frozen toaster pastry", points: -1),
        Ingredient(name: "Frozen tater tot", points: -1),
        Ingredient(name: "Frozen taquito", points: -1),
        Ingredient(name: "Frozen sandwich", points: -1),
        Ingredient(name: "Frozen pot pie", points: -1),
        Ingredient(name: "Frozen pizza", points: -1),
        Ingredient(name: "Frozen onion ring", points: -1),
        Ingredient(name: "Frozen fried food", points: -1),
        Ingredient(name: "Frozen French fries", points: -1),
        Ingredient(name: "Frozen corndog", points: -1),
        Ingredient(name: "Frozen chimichanga", points: -1),
        Ingredient(name: "Frozen burrito", points: -1),
        Ingredient(name: "Frozen breaded chicken nugget", points: -1),
        Ingredient(name: "Flour tortilla", points: 0),
        Ingredient(name: "Fries", points: -1),
        Ingredient(name: "Fried fish", points: -1),
        Ingredient(name: "Fried chicken", points: -1),
        Ingredient(name: "Flaxseed oil", points: 1),
        Ingredient(name: "Flaxseed meal", points: 1),
        Ingredient(name: "Flaxseed", points: 1),
        Ingredient(name: "Flavored coffee creamer", points: -1),
        Ingredient(name: "Fish stick", points: -1),
        Ingredient(name: "Fig vinegar", points: 1),
        Ingredient(name: "Fig Newtons", points: 0),
        Ingredient(name: "Figs", points: 1),
        Ingredient(name: "Fettuccine", points: 0),
        Ingredient(name: "Feta cheese", points: 1),
        Ingredient(name: "Fennel", points: 1),
        Ingredient(name: "Fava beans", points: 1),
        Ingredient(name: "Farro", points: 1),
        Ingredient(name: "Fajita seasoning", points: 0),
        Ingredient(name: "Enriched flour", points: -1),
        Ingredient(name: "Energy drinks", points: -1),
        Ingredient(name: "Endive", points: 1),
        Ingredient(name: "Emmer wheat", points: 1),
        Ingredient(name: "Elderberry", points: 1),
        Ingredient(name: "Eggs", points: 1),
        Ingredient(name: "Edamame", points: 1),
        Ingredient(name: "Durian", points: 1),
        Ingredient(name: "Dragon fruit", points: 1),
        Ingredient(name: "Donut", points: -1),
        Ingredient(name: "Dill", points: 1),
        Ingredient(name: "Dijon mustard", points: 0),
        Ingredient(name: "Diet soda", points: -1),
        Ingredient(name: "Deli meat", points: -1),
        Ingredient(name: "Dates", points: 1),
        Ingredient(name: "Dark chocolate", points: 0),
        Ingredient(name: "Dark brown sugar", points: 0),
        Ingredient(name: "Dandelion greens", points: 1),
        Ingredient(name: "Daikon radish", points: 1),
        Ingredient(name: "Currants", points: 1),
        Ingredient(name: "Cumin", points: 1),
        Ingredient(name: "Cucumber", points: 1),
        Ingredient(name: "Cranberry sauce", points: 0),
        Ingredient(name: "Cranberry", points: 1),
        Ingredient(name: "Cotton candy", points: -1),
        Ingredient(name: "Cottage cheese", points: 1),
        Ingredient(name:"Cotija cheese", points: 1),
        Ingredient(name: "Corn syrup", points: 0),
        Ingredient(name: "Cornstarch", points: 0),
        Ingredient(name: "Corn snack", points: -1),
        Ingredient(name: "Corn oil", points: 0),
        Ingredient(name: "Cornmeal", points: 0),
        Ingredient(name: "Corn flake", points: 0),
        Ingredient(name: "Corn dog", points: 0),
        Ingredient(name: "Corn chip", points: 0),
        Ingredient(name: "Cornbread", points: 0),
        Ingredient(name: "Corn", points: 0),
        Ingredient(name: "Cookies", points: -1),
        Ingredient(name: "Concord grapes", points: 1),
        Ingredient(name: "Cola", points: 0),
        Ingredient(name: "Cod", points: 1),
        Ingredient(name: "Coconut water", points: 1),
        Ingredient(name: "Coconut oil", points: 0),
        Ingredient(name: "Coconut milk", points: 0),
        Ingredient(name: "Coconut flour", points: 1),
        Ingredient(name: "Cocoa Puff", points: 0),
        Ingredient(name: "Cocktail sauce", points: -1),
        Ingredient(name: "Clams", points: 1),
        Ingredient(name: "Cinnamon sugar", points: 0),
        Ingredient(name: "Cinnamon", points: 1),
        Ingredient(name: "Cilantro", points: 1),
        Ingredient(name: "Chocolate syrup", points: -1),
        Ingredient(name: "Chocolate-coated candy", points: -1),
        Ingredient(name: "Chocolate chip", points: 0),
        Ingredient(name: "Chocolate bar", points: -1),
        Ingredient(name: "Chive", points: 1),
        Ingredient(name: "Chickpea flour", points: 1),
        Ingredient(name: "Chickpea", points: 1),
        Ingredient(name: "Chicken wing", points: 0),
        Ingredient(name: "Chicken thigh", points: 0),
        Ingredient(name: "Chicken nugget", points: -1),
        Ingredient(name: "Chicken breast", points: 0),
        Ingredient(name: "Chia seed", points: 1),
        Ingredient(name: "Chex Mix", points: 0),
        Ingredient(name: "Chervil", points: 1),
        Ingredient(name: "Cheez-Its", points: 0),
        Ingredient(name: "Cheese whiz", points: -1),
        Ingredient(name: "Cheese spread", points: -1),
        Ingredient(name: "Cheese puffs", points: -1),
        Ingredient(name: "Cheese-flavored snack", points: -1),
        Ingredient(name: "Cheese-flavored popcorn", points: -1),
        Ingredient(name: "Cheese curl", points: -1),
        Ingredient(name: "Cheese ball", points: -1),
        Ingredient(name: "Cheddar cheese", points: 0),
        Ingredient(name: "Chard", points: 1),
        Ingredient(name: "Celery root", points: 1),
        Ingredient(name: "Celery", points: 1),
        Ingredient(name: "Celeriac", points: 1),
        Ingredient(name: "Cayenne pepper", points: 0),
        Ingredient(name: "Cauliflower", points: 1),
        Ingredient(name: "Cashew butter", points: 1),
        Ingredient(name: "Cashew", points: 1),
        Ingredient(name: "Carrot", points: 1),
        Ingredient(name: "Cardamon", points: 1),
        Ingredient(name: "Caramel", points: -1),
        Ingredient(name: "Cap’n Crunch", points: 0),
        Ingredient(name: "Caper", points: 1),
        Ingredient(name: "Cantaloupe", points: 1),
        Ingredient(name: "Canned Vienna sausage", points: -1),
        Ingredient(name: "Canned tuna", points: 0),
        Ingredient(name: "Canned spaghetti", points: -1),
        Ingredient(name: "Canned soup", points: -1),
        Ingredient(name: "Canned ravioli", points: -1),
        Ingredient(name: "Canned processed meat", points: -1),
        Ingredient(name: "Canned pasta", points: -1),
        Ingredient(name: "Canned meatball", points: -1), // MARK: CONTINUE SINGULARI-ATING HERE
        Ingredient(name: "Canned creamy soup", points: -1),
        Ingredient(name: "Canned chilli", points: -1),
        Ingredient(name: "Candy bar", points: -1),
        Ingredient(name: "Cake", points: -1),
        Ingredient(name: "Cactus", points: 1),
        Ingredient(name: "Cacao powder", points: 1),
        Ingredient(name: "Cacao nib", points: 1),
        Ingredient(name: "Cabbage", points: 1),
        Ingredient(name: "Butternut squash", points: 1),
        Ingredient(name: "Buttermilk", points: 1),
        Ingredient(name: "Burrito", points: -1),
        Ingredient(name: "Burger", points: -1),
        Ingredient(name: "Bulgur", points: 1),
        Ingredient(name: "Buckwheat", points: 1),
        Ingredient(name: "Brussels sprout", points: 1),
        Ingredient(name: "Brown sugar", points: 0),
        Ingredient(name: "Brown rice vinegar", points: 1),
        Ingredient(name: "Brown rice syrup", points: 0),
        Ingredient(name: "Brown rice", points: 1),
        Ingredient(name: "Brown mustard", points: 0),
        Ingredient(name: "Brownie", points: -1),
        Ingredient(name: "Broccolini", points: 1),
        Ingredient(name: "Broccoli", points: 1),
        Ingredient(name: "Bread", points: -1),
        Ingredient(name: "Boxed scalloped potato", points: -1),
        Ingredient(name: "Boxed macaroni and cheese", points: -1),
        Ingredient(name: "Boxed au gratin potato", points: -1),
        Ingredient(name: "Bottled salad dressing", points: -1),
        Ingredient(name: "Bottled frappuccino", points: -1),
        Ingredient(name: "Bok choy", points: 1),
        Ingredient(name: "Blue potato", points: 1),
        Ingredient(name: "Blue cheese", points: 0),
        Ingredient(name: "Blueberry", points: 1),
        Ingredient(name: "Blood orange", points: 1),
        Ingredient(name: "Black truffle", points: 1),
        Ingredient(name: "Black sesame seed", points: 1),
        Ingredient(name: "Black rice", points: 1),
        Ingredient(name: "Black pepper", points: 0),
        Ingredient(name: "Black olive", points: 0),
        Ingredient(name: "Black-eyed pea", points: 1),
        Ingredient(name: "Black currant", points: 1),
        Ingredient(name: "Black bean", points: 1),
        Ingredient(name: "BHT (Butylated hydroxytoluene)", points: -1),
        Ingredient(name: "BHA (Butylated hydroxyanisole)", points: -1),
        Ingredient(name: "Bell peppers", points: 0),
        Ingredient(name: "Beet", points: 1),
        Ingredient(name: "Beef sirloin", points: 0),
        Ingredient(name: "BBQ sauce", points: 0),
        Ingredient(name: "Basmati rice", points: 0),
        Ingredient(name: "Barley", points: 1),
        Ingredient(name: "Banana", points: 1),
        Ingredient(name: "Bamboo shoots", points: 1),
        Ingredient(name: "Balsamic vinegar", points: 0),
        Ingredient(name: "Baby spinach", points: 0),
        Ingredient(name: "Avocado oil", points: 1),
        Ingredient(name: "Avocado", points: 1),
        Ingredient(name: "Aspartame", points: -1),
        Ingredient(name: "Asparagus", points: 1),
        Ingredient(name: "Arugula", points: 1),
        Ingredient(name: "Artificial sweeteners", points: -1),
        Ingredient(name: "Artificial preservatives", points: -1),
        Ingredient(name: "Artificial food coloring", points: -1),
        Ingredient(name: "Artificial flavorings", points: -1),
        Ingredient(name: "Artichoke", points: 1),
        Ingredient(name: "Arrowroot", points: 1),
        Ingredient(name: "Apricot oil", points: 1),
        Ingredient(name: "Apricot", points: 1),
        Ingredient(name: "Applesauce", points: 1),
        Ingredient(name: "Apple juice", points: 0),
        Ingredient(name: "Apple cider vinegar", points: 0),
        Ingredient(name: "Apple cider", points: 0),
        Ingredient(name: "Apple", points: 1),
        Ingredient(name: "Animal crackers", points: 0),
        Ingredient(name: "Anchovy paste", points: 1),
        Ingredient(name: "Anchovy", points: 1),
        Ingredient(name: "Ancho chiles", points: 1),
        Ingredient(name: "Almond milk", points: 1),
        Ingredient(name: "Almond flour", points: 1),
        Ingredient(name: "Almond extract", points: 1),
        Ingredient(name: "Almond butter", points: 1),
        Ingredient(name: "Almond", points: 1),
        Ingredient(name: "Agave syrup", points: -1),
        Ingredient(name: "Agave nectar", points: 0),
        Ingredient(name: "Acorn squash", points: 1),
        Ingredient(name: "Acesulfame potassium​", points: -1)
    ] {
        didSet {
            save()
        }
    }

    @Published var presetIngredientsSearchTerm = ""

    var presetIngredientsFiltered: Binding<[Ingredient]> {
        Binding (
            get: {
                if self.presetIngredientsSearchTerm == "" { return self.presetIngredients }
                return self.presetIngredients.filter {
                    $0.name.lowercased().contains(self.presetIngredientsSearchTerm.lowercased())
                }
            },
            set: { _ in
                print("no dont u dare")
//                self.presetIngredients = $0
            }
        )
    }
        
    init() {
        presetIngredients.sort(by: { $0.name < $1.name })
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "ingredients.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedSelectedIngredients = try? propertyListEncoder.encode(selectedIngredients)
        try? encodedSelectedIngredients?.write(to: archiveURL, options: .noFileProtection)

    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedIngredientData = try? Data(contentsOf: archiveURL),
            let ingredientsDecoded = try? propertyListDecoder.decode([Ingredient].self, from: retrievedIngredientData) {
            selectedIngredients = ingredientsDecoded
        }
    }
}
