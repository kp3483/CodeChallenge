//
//  GuessedViewModel.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/12/22.
//

import Foundation
import RealmSwift

protocol GuessedViewModelDelegate: AnyObject {
    func dataLoaded()
}

class GuessedViewModel {
    
    var questions: [Question] = []
    var filteredQuestions: [Question] = []
    
    weak var delegate: GuessedViewModelDelegate?
    
    var realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        } catch {
            print(error)
        }
    }
    
    func fetchQuestions() {
        questions = []
        let realmQuestions = realm?.objects(QuestionRealm.self)
        realmQuestions?.elements.forEach({ question in
            questions.append(Question(id: question.id, title: question.title))
        })
        
        filteredQuestions = questions
        delegate?.dataLoaded()
    }
    
    func filterExistingQuestions(filter: String) {
        filteredQuestions = questions.filter({ question in
            question.title.lowercased().contains(filter.lowercased())
        })
        delegate?.dataLoaded()
    }
}
