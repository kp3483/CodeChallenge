//
//  Answer.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/14/22.
//

import Foundation

struct Answer: Codable {
    let questionID: Int
    let answerID: Int
    let answer: String?
    let isAccepted: Bool
    
    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case answerID = "answer_id"
        case answer = "body_markdown"
        case isAccepted = "is_accepted"
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
