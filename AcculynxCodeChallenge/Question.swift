//
//  Question.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/13/22.
//

import Foundation
import RealmSwift

struct Question: Codable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case title
    }
}

class QuestionRealm: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var title: String = ""
    
    convenience init(id: Int, title: String) {
        self.init()
        
        self.id = id
        self.title = title
    }
}

struct QuestionResponse: Codable {
    let questions: [Question]
    let quotaRemaining: Int
    
    enum CodingKeys: String, CodingKey {
        case questions = "items"
        case quotaRemaining = "quota_remaining"
    }
}
