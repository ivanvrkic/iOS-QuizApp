//
//  QuizButton.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 08.05.2021..
//

import Foundation
import UIKit

class QuizButton: UIButton {
    private var index: Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func buildView() {
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        self.layer.cornerRadius = 25
    }
    
    public func set(title: String, index:Int) {
        self.setTitle(title, for: .normal)
        self.index=index
    }
    
    
    public func getIndex() -> Int {
        return self.index
    }
    
}
