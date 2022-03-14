//
//  QuestionsViewModel.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/12/22.
//

import Foundation

protocol QuestionsViewModelDelegate: AnyObject {
    func dataLoaded()
}

class QuestionsViewModel {
    
    weak var delegate: QuestionsViewModelDelegate?
    let session = URLSession.shared
    let decoder = JSONDecoder()
    var questions: [Question] = []
    
//    private let baseUrl = "https://api.stackexchange.com"
    
    func loadQuestions(text: String) {
        let cleaned = text.replacingOccurrences(of: " ", with: "%20")
    
        guard let url = URL(string: "https://api.stackexchange.com/2.3/search/advanced?fromdate=1630454400&order=desc&sort=activity&accepted=True&answers=2&tagged=\(cleaned)&site=stackoverflow") else {
            return
        }
        
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let uwData = data else {
                return
            }
            
             // TODO: If I have time handle Errors
            do {
                let questionsResponse = try self?.decoder.decode(QuestionResponse.self, from: uwData)
                self?.questions = questionsResponse?.questions ?? []
                DispatchQueue.main.async {
                    self?.delegate?.dataLoaded()
                }
            } catch {
                print(error)
            }
            
        })
        
        task.resume()
    }
}
