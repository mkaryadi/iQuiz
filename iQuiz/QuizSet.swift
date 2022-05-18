//
//  QuizSet.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/17/22.
//

import UIKit

class QuizSet : NSObject, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(topic, forKey: "topic")
        coder.encode(questions, forKey: "questions")
        coder.encode(desc, forKey: "desc")
    }
    
    required init?(coder: NSCoder) {
        topic = coder.decodeObject(forKey: "topic") as! String
        questions = coder.decodeObject(forKey: "questions") as! [Question]
        desc = coder.decodeObject(forKey: "desc") as! String
    }
    
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

class Question : NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(question, forKey: "question")
        coder.encode(answers, forKey: "answers")
        coder.encode(correct, forKey: "correct")
    }
    
    required init?(coder: NSCoder) {
        question = coder.decodeObject(forKey: "question") as! String
        answers = coder.decodeObject(forKey: "answers") as! [String]
        correct = coder.decodeInteger(forKey: "correct") as! Int
    }
    
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
