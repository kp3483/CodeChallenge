//
//  QuestionsTableViewCell.swift
//  AcculynxCodeChallenge
//
//  Created by Kyle Pratt on 3/12/22.
//

import UIKit

// TODO: If I have time look into adding a date and answer count to this cell
class QuestionsTableViewCell: UITableViewCell {
    
    let questionsLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        updateView()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateView() {
        addSubview(questionsLabel)
    }
    
    func setupView() {
        questionsLabel.textColor = UIColor(red: 62/255, green: 73/255, blue: 122/255, alpha: 1.0)
        questionsLabel.numberOfLines = 0
    }
    
    func setupConstraints() {
        questionsLabel.layout(using: [
            questionsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            questionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            questionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            questionsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func setup(question: Question) {
        print(question.id)
        questionsLabel.text = question.title
    }
}
