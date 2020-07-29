//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Yegor Heiz on 28.07.2020.
//  Copyright © 2020 Yegor Heiz. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefenitionLabel: UILabel!
    
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        calculatePersonalityResult()
    }
    
    func calculatePersonalityResult(){
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map { $0.type }
        
        for responseType in responseTypes {
            var newCount = 1
            
            if let oldCount = frequencyOfAnswers[responseType] {
                newCount = oldCount + 1
            }
            
            frequencyOfAnswers[responseType] = newCount
        }
        
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: {
            (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        } )
        
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)"
        resultDefenitionLabel.text = mostCommonAnswer.defenition
    }
    
}
