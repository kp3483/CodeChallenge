//
//  GuessedViewController.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/12/22.
//

import UIKit

class GuessedViewController: UIViewController {

    //let guessedViewModel = GuessedViewModel()
    let guessedQuestionsSearchBar = UISearchTextField(frame: .zero) // If time keep this for filtering
    let guessedQuestions = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setupView()
        setupConstraints()

    }
    
    func updateView() {
        view.addSubview(guessedQuestionsSearchBar)
        view.addSubview(guessedQuestions)
    }
    
    func setupView() {
        guessedQuestionsSearchBar.placeholder = "Search"
    }
    
    func setupConstraints() {
        guessedQuestionsSearchBar.layout(using: [
            guessedQuestionsSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            guessedQuestionsSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            guessedQuestionsSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        guessedQuestions.layout(using: [
            guessedQuestions.topAnchor.constraint(equalTo: guessedQuestionsSearchBar.bottomAnchor, constant: 8),
            guessedQuestions.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            guessedQuestions.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            guessedQuestions.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
    }
}
