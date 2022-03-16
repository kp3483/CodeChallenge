//
//  GuessAnswerViewModel.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/14/22.
//

import Foundation
import RealmSwift

protocol GuessAnswerViewModelDelegate: AnyObject {
    func dataLoaded()
}

enum GuessState {
    case notGuessed, guessedCorrectly, guessedIncorrectly
}

class GuessAnswerViewModel {
    
    weak var delegate: GuessAnswerViewModelDelegate?
    var answers: [Answer] = []
    var selectedAnswer: Answer?
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    let question: Question
    
    var realm: Realm?
    
    init(question: Question) {
        self.question = question
        
        do {
            realm = try Realm()
        } catch {
            print(error)
        }

        loadAnswers(questionID: question.id)
    }
    
    func loadAnswers(questionID: Int) {

        guard let url = URL(string: "https://api.stackexchange.com/2.3/questions/\(questionID)/answers?order=desc&sort=activity&site=stackoverflow&filter=!*MZqiH2u6968c83X") else {
            return
        }
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let uwData = data else {
                return
            }
            do {
                let answersResponse = try self?.decoder.decode(AnswerResponse.self, from: uwData)
                self?.answers = answersResponse?.answers ?? []
                DispatchQueue.main.async {
                    self?.delegate?.dataLoaded()
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func guessState(currentAnswer: Answer) -> GuessState {
        guard let selected = selectedAnswer else {
            return .notGuessed
        }
 
        if selected.answerID == currentAnswer.answerID && selected.isAccepted {
            return .guessedCorrectly
        } else if selected.answerID == currentAnswer.answerID && !selected.isAccepted {
            return .guessedIncorrectly
        } else {
            return .notGuessed
        }
    }
  
    func storeQuestion() {
        guard let uwRealm = realm else { return }
        let realmQuestion = QuestionRealm(id: question.id, title: question.title)
        do {
            try uwRealm.write {
                uwRealm.add(realmQuestion, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func storeAnswers() {
        guard let uwRealm = realm else { return }
        
        var realmAnswers: [AnswerRealm] = []
        answers.forEach({ answer in
            let newAnswer = AnswerRealm(questionID: answer.questionID, answerID: answer.answerID, answer: answer.answer ?? "", isAccepted: answer.isAccepted, upVote: answer.upVote, downVote: answer.downVote)
            realmAnswers.append(newAnswer)
        })
        do {
            try uwRealm.write {
                uwRealm.add(realmAnswers, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func calculateAndStore() {
        guard let uwSelectedAnswer = selectedAnswer else { return }
        let isAccepted = uwSelectedAnswer.isAccepted ? 10 : -5
        let vote = uwSelectedAnswer.upVote - uwSelectedAnswer.downVote
        let score = isAccepted + vote
        
        guard let uwRealm = realm else { return }
        let realmGuess = GuessRealm(id: UUID().uuidString, questionID: question.id, isAccepted: uwSelectedAnswer.isAccepted, score: score)
        do {
            try uwRealm.write {
                uwRealm.add(realmGuess, update: .modified)
            }
        } catch {
            print(error)
        }
    }
}
