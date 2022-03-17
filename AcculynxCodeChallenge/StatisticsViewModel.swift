//
//  StatisticsViewModel.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/15/22.
//

import Foundation
import RealmSwift

protocol StatisticsViewModelDelegate: AnyObject {
    func dataLoaded()
}

class StatisticsViewModel {
    
    var guesses: [Guess] = []
    var score: Int = 0
    
    weak var delegate: StatisticsViewModelDelegate?
    
    var realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        } catch {
            print(error)
        }
    }
    
    func fetchGuesses() {
        guesses = []
        let realmGuesses = realm?.objects(GuessRealm.self)
        realmGuesses?.elements.forEach({ guess in
            guesses.append(Guess(id: guess.id, questionID: guess.questionID, isAccepted: guess.isAccepted, score: guess.score))
        })
        
        delegate?.dataLoaded()
    }
    
    func calculateScore() -> Int {
        var score = 0
        guesses.forEach({ guess in
            score += guess.score
        })
        return score
    }
    
    func calculateStreak() -> Int {
        let defaults = UserDefaults.standard
        let streak = defaults.integer(forKey: "streak")
        return streak
    }
    
    func calculateTotalCorrect() -> Int {
        var totalCorrect = 0
        guesses.forEach({ guess in
            if guess.isAccepted {
                totalCorrect += 1
            }
        })
        return totalCorrect
    }
}
