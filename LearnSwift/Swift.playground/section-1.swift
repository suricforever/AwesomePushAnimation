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

let sortNUmbers = sorted([1,3,5,2,6,78,10]){$0 < $1}
sortNUmbers

//classs and object

class NamedShape {
    
    var numbersOfSides: Int = 0
    var name: String
    
    
    init(name: String) {
        self.name = name
    }
    
    
    func simpleDescripition() -> String {
        return "A shape with \(numbersOfSides) sides."
    }
}

class Square: NamedShape {
    var sideLength:Double
    
    init(sideLength:Double, name:String) {
        self.sideLength = sideLength
        super.init(name: name)
        numbersOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescripition() -> String {
        return "A Square with sides of length \(sideLength)"
    }
}

let test = Square(sideLength: 5, name: "my test square")
test.area()
test.simpleDescripition()


class EquilateralTrianggle: NamedShape {
    
    var sideLength: Double = 0.0
    
    init(sideLength:Double, name:String) {
        self.sideLength = sideLength
        super.init(name: name)
        numbersOfSides = 4
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescripition() -> String {
        return "A Equilateral Trianggle with sides of length \(sideLength)"
    }
    
}

var trianggel = EquilateralTrianggle(sideLength: 3.1, name: "my trianggle")
trianggel.perimeter
trianggel.perimeter = 9.9
trianggel.sideLength


class TriangleAndSquare {
    var trianggel: EquilateralTrianggle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet {
            trianggel.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        trianggel = EquilateralTrianggle(sideLength: size, name: name)
    }
}

var trianggelAndSquare = TriangleAndSquare(size: 10, name: "other test shape")
trianggelAndSquare.trianggel.sideLength
trianggelAndSquare.square.sideLength
trianggelAndSquare.square = Square(sideLength: 50, name: "Larger Square")
trianggelAndSquare.trianggel.sideLength


