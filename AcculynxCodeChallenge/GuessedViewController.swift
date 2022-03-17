//
//  GuessedViewController.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/12/22.
//

import UIKit

class GuessedViewController: UIViewController {

    let guessedViewModel = GuessedViewModel()
    let guessedQuestionsSearchBar = UISearchTextField(frame: .zero) // If time keep this for filtering
    let guessedQuestions = UITableView(frame: .zero)
    let identifier = "cellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setupView()
        setupConstraints()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guessedViewModel.fetchQuestions()
    }
    
    func updateView() {
        view.addSubview(guessedQuestionsSearchBar)
        view.addSubview(guessedQuestions)
    }
    
    func setupView() {
        guessedQuestionsSearchBar.placeholder = "Search"
        guessedQuestionsSearchBar.delegate = self
        
        guessedViewModel.delegate = self
        guessedQuestions.delegate = self
        guessedQuestions.dataSource = self
        guessedQuestions.register(QuestionAnswerTableViewCell.self, forCellReuseIdentifier: identifier)
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

extension GuessedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            let trimmed = text.components(separatedBy: .whitespacesAndNewlines).joined()
            guessedViewModel.filterExistingQuestions(filter: trimmed)
        }
        
        return true
    }
}

extension GuessedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guessedViewModel.filteredQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? QuestionAnswerTableViewCell
        let question = guessedViewModel.filteredQuestions[indexPath.row]
        cell?.setup(question: question.title)
        return cell ?? QuestionAnswerTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let question = guessedViewModel.filteredQuestions[indexPath.row]
        let guessAnswerViewModel = GuessAnswerViewModel(question: question)
        let answerController = GuessAnswerViewController(viewModel: guessAnswerViewModel)
        navigationController?.pushViewController(answerController, animated: true)
    }
}

extension GuessedViewController: GuessedViewModelDelegate {
    func dataLoaded() {
        guessedQuestions.reloadData()
    }
}
