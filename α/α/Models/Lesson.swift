//
//  Lesson.swift
//  α
//
//  Created by Sola on 2021/1/16.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

struct Lesson {
    var id: Int
    var title: String
    
    var pdfPath: String
    var vocab: [Text]
    var sentences: [Text]
    
    // MARK: - IO
    
    static func loadLessons() -> [Lesson] {
        var lessons: [Lesson] = []
        for i in 1...50 {
            lessons.append(Lesson(id: i, title: "Lesson" + String(i), pdfPath: "", vocab: [], sentences: []))
        }
        
        lessons[0] = Lesson(id: 1, title: "Lesson 1", pdfPath: "", vocab: [], sentences: [])
        lessons[1] = Lesson(id: 2, title: "Lesson 2", pdfPath: "", vocab: [], sentences: [])
        lessons[2] = Lesson(id: 3, title: "Lesson 3", pdfPath: "", vocab: [
            Text(greek: "γράφω", english: "write, draw [cf. autograph]"),
            Text(greek: "ἐθέλω", english: "(+ infinitive) be willing (to), wish (to)")
        ], sentences: [
            Text(greek: "παιδεύεις καὶ οὐ κλέπτεις.", english: "You teach and you don't steal."),
            Text(greek: "μὴ γράφε· σπεῦδε φυλάττειν.", english: "Don't write: hasten to protect.")
        ])
        
        return lessons
    }
}
