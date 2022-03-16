//
//  GuessAnswerViewController.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/13/22.
//

import UIKit

class GuessAnswerViewController: UIViewController {

    let guessAnswerViewModel: GuessAnswerViewModel
    let questionLabel = UILabel(frame: .zero)
    let answersTableView = UITableView(frame: .zero)
    let identifier = "cellReuseIdentifier"
    
    init(viewModel: GuessAnswerViewModel) {
        self.guessAnswerViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setupView()
        setupConstraints()
        
        view.backgroundColor = .white
    }
    
    func updateView() {
        view.addSubview(questionLabel)
        view.addSubview(answersTableView)
    }
    
    func setupView() {
        questionLabel.textColor = UIColor(red: 62/255, green: 73/255, blue: 122/255, alpha: 1.0)
        questionLabel.numberOfLines = 0
        questionLabel.text = guessAnswerViewModel.question.title
        questionLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        answersTableView.delegate = self
        answersTableView.dataSource = self
        answersTableView.register(QuestionAnswerTableViewCell.self, forCellReuseIdentifier: identifier)
        
        guessAnswerViewModel.delegate = self
        
        let navButton = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submit))
        navigationItem.rightBarButtonItem = navButton
    }
    
    func setupConstraints() {
        questionLabel.layout(using: [
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        answersTableView.layout(using: [
            answersTableView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8),
            answersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            answersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            answersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    @objc func submit() {
        
        guard let _ = guessAnswerViewModel.selectedAnswer else { return }
        guessAnswerViewModel.storeQuestion()
        guessAnswerViewModel.storeAnswers()
        guessAnswerViewModel.calculateAndStore()
        answersTableView.reloadData()
    }
}

extension GuessAnswerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guessAnswerViewModel.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? QuestionAnswerTableViewCell
        let answer = guessAnswerViewModel.answers[indexPath.row]
        cell?.setup(question: answer.answer ?? "", guessState: guessAnswerViewModel.guessState(currentAnswer: answer))
        return cell ?? QuestionAnswerTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answer = guessAnswerViewModel.answers[indexPath.row]
        guessAnswerViewModel.selectedAnswer = answer
    }
}

extension GuessAnswerViewController: GuessAnswerViewModelDelegate {
    func dataLoaded() {
        answersTableView.reloadData()
    }
}
