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
    
    // TODO: Load from disk
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
        lessons[3] = Lesson(id: 4, title: "Lesson 4", pdfPath: "", vocab: [
            Text(greek: "v1", english: "1"),
            Text(greek: "v2", english: "2")
        ], sentences: [
            Text(greek: "s1", english: "1"),
            Text(greek: "s2", english: "2")
        ])
        lessons[4] = Lesson(id: 5, title: "Lesson 4", pdfPath: "", vocab: [
            Text(greek: "v3", english: "3"),
            Text(greek: "v4", english: "4")
        ], sentences: [
            Text(greek: "s3", english: "3"),
            Text(greek: "s4", english: "4")
        ])
        lessons[5] = Lesson(id: 6, title: "Lesson 4", pdfPath: "", vocab: [
            Text(greek: "v5", english: "5"),
            Text(greek: "v6", english: "6")
        ], sentences: [
            Text(greek: "s5", english: "5"),
            Text(greek: "s6", english: "6")
        ])
        
        return lessons
    }
}
