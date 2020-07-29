//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Yegor Heiz on 28.07.2020.
//  Copyright © 2020 Yegor Heiz. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multipleLable1: UILabel!
    @IBOutlet weak var multipleLable2: UILabel!
    @IBOutlet weak var multipleLable3: UILabel!
    @IBOutlet weak var multipleLable4: UILabel!
    @IBOutlet weak var multipleSwitch1: UISwitch!
    @IBOutlet weak var multipleSwitch2: UISwitch!
    @IBOutlet weak var multipleSwitch3: UISwitch!
    @IBOutlet weak var multipleSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    let questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type:.single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
        ]),
        
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
        ]),
        
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous",
                           type: .rabbit),
                    Answer(text: "I barely notice them",
                           type: .turtle),
                    Answer(text: "I love them", type: .dog)
        ])
    ]
    
    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI(){
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        navigationItem.title = "Question #\(questionIndex+1)"
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStackView(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStackView(using answers: [Answer]) {
        multipleStackView.isHidden = false
        
        multipleSwitch1.isOn = false
        multipleSwitch2.isOn = false
        multipleSwitch3.isOn = false
        multipleSwitch4.isOn = false
        
        multipleLable1.text = answers[0].text
        multipleLable2.text = answers[1].text
        multipleLable3.text = answers[2].text
        multipleLable4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]){
        rangedStackView.isHidden = false
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    func nextQuestion(){
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        // TODO: Fix bug when used toggle multiple times the same switch
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            // TODO: Remove
            print("wut")
        }
        
        nextQuestion()
    }
    
    
    @IBAction func multipleSwitchToggled(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        
        if multipleSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        
        if multipleSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        
        if multipleSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        
        if multipleSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: UIButton) {
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        if 0...0.25 ~= rangedSlider.value {
            answersChosen.append(currentAnswers[0])
        } else if 0.25...0.5 ~= rangedSlider.value {
            answersChosen.append(currentAnswers[1])
        } else if 0.5...0.75 ~= rangedSlider.value {
            answersChosen.append(currentAnswers[2])
        } else if 0.75...1 ~= rangedSlider.value {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
}
