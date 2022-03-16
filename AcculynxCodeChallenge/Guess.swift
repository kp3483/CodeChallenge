//
//  Guess.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/15/22.
//

import Foundation
import RealmSwift

struct Guess {
    let id: String
    let questionID: Int
    let isAccepted: Bool
    let score: Int
    
}

class GuessRealm: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var questionID: Int = 0
    @Persisted var isAccepted: Bool = false
    @Persisted var score: Int = 0
    
    convenience init(id: String, questionID: Int, isAccepted: Bool, score: Int) {
        self.init()
        
        self.id = id
        self.questionID = questionID
        self.isAccepted = isAccepted
        self.score = score
    }
}
