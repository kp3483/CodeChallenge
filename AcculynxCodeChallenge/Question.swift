//
//  Question.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/13/22.
//

import Foundation

struct Question: Codable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case title
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
