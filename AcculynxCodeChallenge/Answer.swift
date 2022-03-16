//
//  Answer.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/14/22.
//

import Foundation
import RealmSwift

struct Answer: Codable {
    let questionID: Int
    let answerID: Int
    let answer: String?
    let isAccepted: Bool
    let upVote: Int
    let downVote: Int
    
    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case answerID = "answer_id"
        case answer = "body_markdown"
        case isAccepted = "is_accepted"
        case upVote = "up_vote_count"
        case downVote = "down_vote_count"
    }
}

class AnswerRealm: Object {
    @Persisted var questionID: Int = 0
    @Persisted(primaryKey: true) var answerID: Int = 0
    @Persisted var answer: String = ""
    @Persisted var isAccepted: Bool = false
    @Persisted var upVote: Int = 0
    @Persisted var downVote: Int = 0

    convenience init(questionID: Int, answerID: Int, answer: String, isAccepted: Bool, upVote: Int, downVote: Int) {
        self.init()
        
        self.questionID = questionID
        self.answerID = answerID
        self.answer = answer
        self.isAccepted = isAccepted
        self.upVote = upVote
        self.downVote = downVote
    }
}

struct AnswerResponse: Codable {
    let answers: [Answer]
    let quotaRemaining: Int
    
    enum CodingKeys: String, CodingKey {
        case answers = "items"
        case quotaRemaining = "quota_remaining"
    }
}
