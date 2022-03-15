//
//  GuessAnswerViewModel.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/14/22.
//

import Foundation

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
    
    init(question: Question) {
        self.question = question
        loadAnswers(questionID: question.id)
    }
    
    func loadAnswers(questionID: Int) {

        guard let url = URL(string: "https://api.stackexchange.com/2.3/questions/\(questionID)/answers?order=desc&sort=activity&site=stackoverflow&filter=!nKzQURFm*e") else {
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
}
