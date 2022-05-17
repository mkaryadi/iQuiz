//
//  QuizSet.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/17/22.
//

import UIKit

class QuizSet {
    let topic : String
    let questions : [Question]
    let desc : String
    var count : Int {
        return questions.count
    }
    
    init(topic: String, desc: String, questions: [Question]) {
        self.topic = topic
        self.questions = questions
        self.desc = desc
    }
}

class Question {
    let question : String
    let answers : [String]
    let correct : Int
    var correctAnswer : String {
        return answers[correct]
    }
    
    init(question: String, answers: [String], correct: Int) {
        self.question = question
        self.answers = answers
        self.correct = correct
    }
}
