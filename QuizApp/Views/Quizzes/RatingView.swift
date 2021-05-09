//
//  RatingView.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 08.05.2021..
//

import Foundation
import UIKit

class RatingView: UIView {
    private var d1: UIImageView!
    private var d2: UIImageView!
    private var d3: UIImageView!
    private var ratingView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
    }
    
    private func buildView() {
        ratingView = UIView()
        let diamond = UIImage(systemName: "diamond.fill")
        let color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        d1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        d1.image = diamond
        d2 = UIImageView(frame: CGRect(x: 20, y: 0, width: 15, height: 15))
        d2.image = diamond
        d3 = UIImageView(frame: CGRect(x: 40, y: 0, width: 15, height: 15))
        d3.image = diamond
        d1.tintColor=color
        d2.tintColor=color
        d3.tintColor=color
        ratingView.addSubview(d1)
        ratingView.addSubview(d2)
        ratingView.addSubview(d3)
        self.addSubview(ratingView)

    }
    
    public func rate(rating: Int) {
        let color = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        switch rating {
        case 1:
            d1.tintColor=color
        case 2:
            d1.tintColor=color
            d2.tintColor=color
        case 3:
            d1.tintColor=color
            d2.tintColor=color
            d3.tintColor=color
        default:
            print("err")
        }
    }
}

