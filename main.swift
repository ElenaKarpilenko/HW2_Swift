//
//  main.swift
//  HW2
//
//  Created by Елена Карпиленко on 9/12/24.
//

import Foundation

print("Hello, World!")

class Game {
    let heroesNames: [String] = ["Archer", "Wizard", "Berserk", "Medic"]
    var heroesHealth: [Int] = [200, 200, 300, 180]
    var heroesDamage: [Int] = [50, 50, 40, 0]
    
    let dragonGorynych = "Змей Горыныч"
    var dragonHealth = 1000
    var dragonDamage = 70
    
    var isGameFinished = false
    var isFirstAttack = Bool.random()
    var round = 0
    var score = 0

    func startGame() {
        print("Начало битвы!")
        while !isGameFinished {
            round += 1
            print("Раунд \(round):")
            
            if isFirstAttack {
                heroesHit()
                wizardAbility()
            } else {
                dragonHit()
            }
            
            printHeroesStats()
            printDragonStats()
            
            if dragonHealth <= 0 {
                print("Герои победили!")
                score += 100
                isGameFinished = true
            } else if heroesHealth.allSatisfy({ $0 <= 0 }) {
                print("\(dragonGorynych) победил!")
                print("Игра окончена. Ваш счет: \(score)")
                isGameFinished = true
            } else {
                if round % 5 == 0 {
                    strengthenDragon()
                }
            }
            print("-------------------------------")
            isFirstAttack.toggle()
        }
    }

    func heroesHit() {
        print("Герои атакуют!")
        for index in 0..<heroesDamage.count {
            if heroesHealth[index] > 0 {
                let damage = index == 0 && Bool.random(withPercentage: 20) ? heroesDamage[index] * 2 : heroesDamage[index]
                dragonHealth -= damage
                score += damage
            }
        }
    }

    func dragonHit() {
        print("Дракон атакует!")
        if Bool.random(withPercentage: 20) {
            print("Змей Горыныч испускает огонь!")
            for index in 0..<heroesHealth.count {
                heroesHealth[index] -= dragonDamage * 2
            }
        } else {
            for index in 0..<heroesHealth.count {
                if index == 2 && Bool.random(withPercentage: 50) {
                    heroesHealth[index] -= dragonDamage * 2
                } else {
                    heroesHealth[index] -= dragonDamage
                }
            }
        }
    }

    func strengthenDragon() {
        print("\(dragonGorynych) усиливается!")
        dragonHealth += 100
        dragonDamage += 10
    }

    func healHeroes() {
        let healAmount = Int.random(in: 30...50)
        for index in 0..<heroesHealth.count {
            if index != 3 && heroesHealth[3] > 0 { // Медик жив
                heroesHealth[index] = min(heroesHealth[index] + healAmount, 200)
                print("\(heroesNames[index]) восстанавливает \(healAmount) здоровья!")
            }
        }
    }

    func wizardAbility() {
        switch Int.random(in: 1...3) {
        case 1:
            print("Маг замораживает Змея Горыныча!")
            return
        case 2:
            print("Маг наносит повышенный урон!")
            dragonHealth -= 100
            score += 100
        case 3:
            print("Маг лечит героев!")
            healHeroes()
        default:
            return
        }
    }

    func printHeroesStats() {
        for (index, name) in heroesNames.enumerated() {
            if heroesHealth[index] > 0 {
                print("Здоровье героя \(name): \(heroesHealth[index])")
            } else {
                print("Герой \(name) мертв")
            }
        }
    }

    func printDragonStats() {
        if dragonHealth > 0 {
            print("Здоровье \(dragonGorynych): \(dragonHealth)")
        } else {
            print("\(dragonGorynych) мертв")
        }
    }
}

extension Bool {
    static func random(withPercentage percentage: Int) -> Bool {
        return Int.random(in: 1...100) <= percentage
    }
}

let game = Game()
game.startGame()
