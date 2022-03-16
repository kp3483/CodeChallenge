//
//  StatisticsViewController.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/15/22.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    let statisticsViewModel = StatisticsViewModel()
    let scoreLabel = UILabel(frame: .zero)
    let currentStreakLabel = UILabel(frame: .zero)
    let totalCorrectLabel = UILabel(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setupView()
        setupConstraints()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        statisticsViewModel.fetchGuesses()
    }
    
    func updateView() {
        view.addSubview(scoreLabel)
        view.addSubview(currentStreakLabel)
        view.addSubview(totalCorrectLabel)
    }
    
    func setupView() {
        scoreLabel.textColor = UIColor(red: 62/255, green: 73/255, blue: 122/255, alpha: 1.0)
        scoreLabel.textAlignment = .center
        scoreLabel.text = "Score: \(0)"
        currentStreakLabel.textColor = UIColor(red: 62/255, green: 73/255, blue: 122/255, alpha: 1.0)
        currentStreakLabel.textAlignment = .center
        currentStreakLabel.text = "Current Streak: \(0)"
        totalCorrectLabel.textColor = UIColor(red: 62/255, green: 73/255, blue: 122/255, alpha: 1.0)
        totalCorrectLabel.textAlignment = .center
        totalCorrectLabel.text = "Total Correct: \(0)"
        
        statisticsViewModel.delegate = self
    }
    
    func setupConstraints() {
        currentStreakLabel.layout(using: [
            currentStreakLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentStreakLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            currentStreakLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        scoreLabel.layout(using: [
            scoreLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            scoreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            scoreLabel.bottomAnchor.constraint(equalTo: currentStreakLabel.topAnchor, constant: -8)
        ])
        totalCorrectLabel.layout(using: [
            totalCorrectLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            totalCorrectLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            totalCorrectLabel.topAnchor.constraint(equalTo: currentStreakLabel.bottomAnchor, constant: 8)
        ])
    }
}

extension StatisticsViewController: StatisticsViewModelDelegate {
    func dataLoaded() {
        scoreLabel.text = "Score: \(statisticsViewModel.calculateScore())"
        // update current streak
        totalCorrectLabel.text = "Total Correct: \(statisticsViewModel.calculateTotalCorrect())"
    }
}
