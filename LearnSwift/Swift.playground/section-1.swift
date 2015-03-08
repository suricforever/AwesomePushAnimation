// Playground - noun: a place where people can play

import UIKit

//string
var str = "Hello, playground"
let label = "The width is "
let width = 54
let widthLabel = label + String(width)
let widthLabel2 = "The width is \(widthLabel)"

//array
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
for buying:String in shoppingList
{
    println(buying)
}

//dictionry
var occupations = ["James": "CelefLand",
    "Durant": "Captain"]
println(occupations)
occupations["James"] = "Miami"
println(occupations)

let emptyArray = [String]()
let emptyDictionary = [String: Float]()

shoppingList = []
occupations = [:]
shoppingList
occupations

//Control Flow
let individualScores = ["56", "78", "100", "43"]
var teamScores = 0
for score in individualScores
{
    if score.toInt() > 50
    {
        teamScores += 3
    }
    else
    {
        teamScores += 1
    }
}
teamScores

//optinal
var optinalString: String? = "Hello"
optinalString = nil

var optinalName: String? = "John Appleseed"
var greeting = "Hello!"




