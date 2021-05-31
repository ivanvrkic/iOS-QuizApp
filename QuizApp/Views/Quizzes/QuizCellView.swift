//
//  QuizCellView.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 07.05.2021..
//

import Foundation
import UIKit

class QuizCellView: UICollectionViewCell {
    private var titleLabel: UILabel!
    private var quizImage: UIImageView!
    private var descriptionLabel: UILabel!
    private var ratingView: RatingView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quizImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            quizImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            quizImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            quizImage.widthAnchor.constraint(equalToConstant: 100),
            quizImage.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo:quizImage.trailingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            ratingView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            ratingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: quizImage.trailingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
        ])
    }
        
    private func buildView() {
        backgroundColor = UIColor(red: 0.5804, green: 0.7725, blue: 0.9882, alpha: 1.0)
        self.clipsToBounds = true
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        self.layer.cornerRadius = 10
        // title label
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        // image
        quizImage = UIImageView()
        
        //description label
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        
        ratingView = RatingView()
        
        self.addSubview(titleLabel)
        self.addSubview(quizImage)
        self.addSubview(descriptionLabel)
        self.addSubview(ratingView)
    }
    
    public func setUp(quiz:Quiz) {
        titleLabel.text = quiz.title
        descriptionLabel.text=quiz.description
        ratingView.rate(rating: quiz.level)
        print(quiz.level)
        guard let url = URL(string: quiz.imageUrl) else { return }
        quizImage.load(url: url)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
