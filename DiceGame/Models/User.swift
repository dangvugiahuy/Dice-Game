//
//  User.swift
//  DiceGame
//
//  Created by Gia Huy on 14/08/2022.
//

import Foundation
import SwiftUI

struct User: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var money: Int
    var highscore: Int
    
    var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    init(id: Int, name: String, money: Int, highscore: Int, imageName: String) {
        self.id = id
        self.name = name
        self.money = money
        self.highscore = highscore
        self.imageName = imageName
    }
}

enum keys: CodingKey {
    case id
    case name
    case money
    case highscore
    case imageName
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else {
            return nil
        }
        do {
            let result = try JSONDecoder().decode([Element].self, from: data)
            print("Init from result: \(result)")
            self = result
        } catch {
            print("Error: \(error)")
            return nil
        }
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        print("Returning \(result)")
        return result
    }
}
