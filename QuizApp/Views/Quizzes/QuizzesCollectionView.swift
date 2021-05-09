//
//  QuizCollectionView.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 07.05.2021..
//

import Foundation
import UIKit
class QuizzesCollectionView: UICollectionView {
    public var router: AppRouterProtocol!
    private let customCellIdentifier: String = "customCell"
    private var quizzes: [QuizCategory:[Quiz]] = [:]
    
    convenience init(router: AppRouterProtocol) {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.router = router
        buildViews()
    }
    
    private func buildViews() {
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        self.isHidden = true
        self.register(QuizCellView.self, forCellWithReuseIdentifier: customCellIdentifier)
        self.register(QuizHeaderView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        self.dataSource = self
        self.delegate = self
        
    }
    public func addQuizzes(quizzes:[QuizCategory:[Quiz]]) {
        self.quizzes = quizzes
        self.reloadData()
    }
}

extension QuizzesCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return quizzes.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array(quizzes)[section].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: customCellIdentifier,
            for: indexPath) as! QuizCellView
        cell.setUp(quiz: Array(quizzes)[indexPath.section].value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! QuizHeaderView
        collectionView.setUpHeader(header: Array(quizzes)[indexPath.section].key.rawValue)
        return collectionView
    }
    
  
}

extension QuizzesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.frame.height*0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.frame.height*0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.showQuizViewController(quiz: Array(quizzes)[indexPath.section].value[indexPath.row])
    }
}
