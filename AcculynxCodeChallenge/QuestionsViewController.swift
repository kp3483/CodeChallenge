//
//  ViewController.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/12/22.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    let questionsViewModel = QuestionsViewModel()
    let questionsSearchBar = UISearchTextField(frame: .zero)
    let stackOverflowQuestions = UITableView(frame: .zero)
    let identifier = "cellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setupView()
        setupConstraints()
    }
    
    func updateView() {
        view.addSubview(questionsSearchBar)
        view.addSubview(stackOverflowQuestions)
    }
    
    func setupView() {
        questionsSearchBar.placeholder = "Search"
        questionsSearchBar.delegate = self
        stackOverflowQuestions.delegate = self
        stackOverflowQuestions.dataSource = self
        stackOverflowQuestions.register(QuestionsTableViewCell.self, forCellReuseIdentifier: identifier)
        questionsViewModel.delegate = self
    }
    
    func setupConstraints() {
        questionsSearchBar.layout(using: [
            questionsSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            questionsSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            questionsSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        stackOverflowQuestions.layout(using: [
            stackOverflowQuestions.topAnchor.constraint(equalTo: questionsSearchBar.bottomAnchor, constant: 8),
            stackOverflowQuestions.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            stackOverflowQuestions.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            stackOverflowQuestions.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
    }
}

extension QuestionsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        questionsViewModel.loadQuestions(text: textField.text ?? "")
        return true
    }
}

extension QuestionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsViewModel.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? QuestionsTableViewCell
        let question = questionsViewModel.questions[indexPath.row]
        cell?.setup(question: question)
        return cell ?? QuestionsTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // init viewModel with a question and load answers
        let answerController = GuessAnswerViewController()
        navigationController?.pushViewController(answerController, animated: true)
    }
}

extension QuestionsViewController: QuestionsViewModelDelegate {
    func dataLoaded() {
        stackOverflowQuestions.reloadData()
    }
}

