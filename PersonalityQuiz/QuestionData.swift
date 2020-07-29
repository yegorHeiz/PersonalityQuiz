//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Yegor Heiz on 28.07.2020.
//  Copyright © 2020 Yegor Heiz. All rights reserved.
//

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐭"
    case turtle = "🐢"
    
    var defenition: String {
        switch self {
            case .dog:
                return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
            case .cat:
                return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
            case .rabbit:
                return "You love everything that's soft. You are healthy and full of energy."
            case .turtle:
                return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race"
        }
    }
}
