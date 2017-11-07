//
//  QuestionObject.swift
//  THPTMath
//
//  Created by hung le on 11/5/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import Foundation

class QuestionObject {
    var testID: String?
    var cateID: String?
    var id: String?
    
    var answerA: String?
    var answerB: String?
    var answerC: String?
    var answerD: String?
    
    var answerTrue: String?
    var answerDetail: String?
    
    var image: String?

    var question: String?
    
    init(question: String, answerA: String, answerB: String, answerC: String,
         answerD: String, image: String) {
        
        self.question = question
        self.answerA = answerA
        self.answerB = answerB
        self.answerC = answerC
        self.answerD = answerD
        self.image = image
    }
}

/*
 MathUtils mathUtils = new MathUtils();
 mathUtils.question = "<b>" + getString(R.string.questionNo) + " " + position + "</b>: "
 + Utils.replaceMath(question.question.trim());
 mathUtils.answer1 = Utils.replaceMath(question.answerList.get(0).answer.trim());
 mathUtils.answer2 = Utils.replaceMath(question.answerList.get(1).answer.trim());
 mathUtils.answer3 = Utils.replaceMath(question.answerList.get(2).answer.trim());
 mathUtils.answer4 = Utils.replaceMath(question.answerList.get(3).answer.trim());
 if (question.image != null
 && !question.image.trim().isEmpty()
 && question.image.startsWith("data")) {
 mathUtils.image = question.image;
 } else {
 mathUtils.image = "";
 }
 fragmentQuestionBinding.webView.loadDataWithBaseURL(
 "file:///android_asset/",
 mathUtils.htmlContain(),
 "text/html", "UTF-8", null);
 
 */

