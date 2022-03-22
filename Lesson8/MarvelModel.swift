//
//  MarvelModel.swift
//  Lesson8
//
//  Created by Светлана on 22.03.2022.
//

import Foundation

struct MarvelModel {
    let parameter: String
    var heroes: [Hero]
}

struct Hero {
    let name: String
    let imageName: String?
    let realName: String?
}

let models: [MarvelModel] = [
    MarvelModel(parameter: "Strength", heroes: [
        Hero(name: "Thor", imageName: "Thor", realName: nil),
        Hero(name: "Drax the Destroyer", imageName: "drax", realName: "Arthur Douglas"),
        Hero(name: "The Thing", imageName: "thing", realName: "Benjamin Jacob \"Ben\" Grimm"),
        Hero(name: "Hulk", imageName: "hulk", realName: "Robert Bruce Banner"),
    ]),
    MarvelModel(parameter: "Endurance", heroes: [
        Hero(name: "Captain America", imageName: "Captain America", realName: "Steve Rogers"),
        Hero(name: "Groot", imageName: "groot", realName: nil),
        Hero(name: "Ant-Man", imageName: "Ant-Man", realName: "Scott Lang"),
        Hero(name: "Wolverine", imageName: "Wolverine", realName: "James Howlett"),
    ]),
    MarvelModel(parameter: "Agility", heroes: [
        Hero(name: "Black Widow", imageName: "Black Widow", realName: "Natalia Romanova"),
        Hero(name: "Black Panther", imageName: "Black Panther", realName: "T'Challa"),
        Hero(name: "Gamora", imageName: "Gamora", realName: nil),
        Hero(name: "Spider-Man", imageName: "Spider-Man", realName: "Peter Parker"),
    ]),
    MarvelModel(parameter: "Intelligence", heroes: [
        Hero(name: "Iron Man", imageName: "Iron Man", realName: "Tony Stark"),
        Hero(name: "Vision", imageName: "Vision", realName: "Victor Shade"),
        Hero(name: "Rocket", imageName: "Rocket", realName: nil),
        Hero(name: "Doctor Strange", imageName: "Doctor Strange", realName: "Stephen Vincent Strange"),
    ]),
]

