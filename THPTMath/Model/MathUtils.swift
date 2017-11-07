//
//  MathUtils.swift
//  THPTMath
//
//  Created by hung le on 11/4/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import Foundation

class MathUtils {
    private let doan1: String = "<!DOCTYPE html>\n" +
    "<html lang=\"en\">\n" +
    "<head>\n" +
    "    <meta charset=\"UTF-8\">\n" +
    "    <title>Title</title>\n" +
    "    <script type=\"text/javascript\" async\n" +
    "            src=\"mathjax/2.7-latest/MathJax.js?config=MML_CHTML\">\n" +
    "    </script>\n" +
    "</head>\n" +
    "<body>\n" +
    "<div class=\"cauhoi\">\n" +
    "    <div class=\"cauhoi_text\">";
    
    public var question: String = "";
    
    private let doan2: String = "</div>\n" +
    "    <div class=\"cauhoi_anh\">";
    
    private let doan2_1: String = "<img width=\"100%\" src='";
    private let doan2_2: String = "<img src='";
    
    public var image: String = "";
    
    private let doan3: String = "'/>" +
    "</div>\n" +
    "</div>\n" +
    "<div class=\"dapan\">\n" +
    "    <div id=\"answer_1\">\n" +
    "        <input type=\"radio\" name=\"answer\" value=\"1\">" +
    "<b>A. </b>";
    
    
    public var answer1: String = "";
    
    private let doan4: String = "</div>\n" +
    "\n" +
    "    <div id=\"answer_2\">\n" +
    "        <input type=\"radio\" name=\"answer\" value=\"2\">" +
    "<b>B. </b>";
    
    public var answer2: String = "";
    
    private let doan5: String = "</div>\n" +
    "    <div id=\"answer_3\">\n" +
    "        <input type=\"radio\" name=\"answer\" value=\"3\">" +
    "<b>C. </b>";
    
    public var answer3: String = "";
    
    private let doan6: String = "</div>\n" +
    "    <div id=\"answer_4\">\n" +
    "        <input type=\"radio\" name=\"answer\" value=\"4\">" +
    "<b>D. </b>";
    
    public var answer4: String = "";
    
    private let doan7: String = "</div>\n" +
    "\n" +
    "\n" +
    "</div>\n" +
    "\n" +
    "<script>\n" +
    "    function checkAnswer() {\n" +
    "        var radios = document.getElementsByName('answer');\n" +
    "        var count = -1;\n" +
    "        for (var i = 0, length = radios.length; i < length; i++) {\n" +
    "            if (radios[i].checked) {\n" +
    "                // do whatever you want with the checked radio\n" +
    "                count = i;\n" +
    "//                return (radios[i].value);\n" +
    "            }\n" +
    "        }\n" +
    "        return count;\n" +
    "\n" +
    "    }\n" +
    "\n" +
    "    function setColor(_select, _true) {\n _dung = parseInt(_true);" +
    "        for (var i = 1; i <= 4; i++) {\n" +
    "            document.getElementById('answer_' + i).style.backgroundColor = 'white';\n" +
    "        }\n" +
    "        _select = parseInt(checkAnswer()) + 1;\n" +
    "        if (_select == _true) {\n" +
    "            document.getElementById('answer_' + _dung).style.backgroundColor = '#2ecc71';\n" +
    "        } else {\n if (_select > 0)" +
    "            document.getElementById('answer_' + _select).style.backgroundColor = '#e74c3c';\n" +
    "            document.getElementById('answer_' + _dung).style.backgroundColor = '#2ecc71';\n" +
    "\n" +
    "        }\n" +
    "    }\n" +
    "   function resetColor() {\n" +
    "        for (var i = 1; i <= 4; i++) {\n" +
    "            document.getElementById('answer_' + i).style.backgroundColor = 'white';\n" +
    "        }\n" +
    "    }\n" +
    "   function callNativeApp (value) {\n" +
    "       try {\n" +
    "           webkit.messageHandlers.callbackHandler.postMessage(value);\n" +
    "       } catch(err) {\n" +
    "           console.log('The native context does not exist yet');\n" +
    "       }\n" +
    "   }" +
    "</script>\n" +
    "<script>\n" +
    "    var rad = document.getElementsByName('answer');\n" +
    "    var prev = null;\n" +
    "    for (var i = 0; i < rad.length; i++) {\n" +
    "        rad[i].onclick = function () {\n" +
    "            (prev) ? console.log(prev.value) : null;\n" +
    "            if (this !== prev) {\n" +
    "                prev = this;\n" +
    "            }\n" +
    "//            console.log(this.value)\n" +
    "            callNativeApp(this.value);\n" +
    "        };\n" +
    "    }\n" +
    "</script>\n" +
    "</body>\n" +
    "</html>";
    
    public func htmlContain() -> String {
        if (image.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty ||
            !image.trimmingCharacters(in: NSCharacterSet.whitespaces).starts(with: "data")) {
            
            return doan1 + question + doan2 + doan2_2 + image + doan3
                + answer1 + doan4 + answer2 + doan5 + answer3 + doan6 + answer4 + doan7;
        } else {
            
            return doan1 + question + doan2 + doan2_1 + image + doan3
                + answer1 + doan4 + answer2 + doan5 + answer3 + doan6 + answer4 + doan7;
        }
    }
    
    public func htmlContain (question: String, image: String, answer1: String,
                             answer2: String, answer3: String, answer4: String) -> String {
        return doan1 + question + doan2 + image + doan3
            + answer1 + doan4 + answer2 + doan5 + answer3 +
            doan6 + answer4 + doan7;
    }
    
    public func replaceMath(string: String) -> String {
        if (!string.isEmpty && string.count >= 3) {
            let indexStartOfText = string.index(string.startIndex, offsetBy: 3)
            let indexEndOfText = string.index(string.endIndex, offsetBy: -3)
            
            if (string.starts(with: "<p>")) {
                return String(string.prefix(through: indexStartOfText))
            }
            if (string.hasSuffix("</p>")) {
                return String(string.suffix(from: indexEndOfText))
            }
        } else {
            return ""
        }
        
        return string
    }
}
