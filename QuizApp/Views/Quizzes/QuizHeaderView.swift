//
//  QuizHeaderView.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 08.05.2021..
//
import Foundation
import UIKit

class QuizHeaderView: UICollectionReusableView {
    private var sectionHeader: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        sectionHeader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sectionHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            sectionHeader.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            sectionHeader.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            sectionHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
    
    private func buildView() {
        sectionHeader = UILabel()
        sectionHeader.textColor = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        sectionHeader.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        
        addSubview(sectionHeader)
    }
    
    public func setUpHeader(header: String) {
        sectionHeader.text = header
    }
}
