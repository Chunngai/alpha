//
//  Lesson.swift
//  α
//
//  Created by Sola on 2021/1/16.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

struct Lesson: Codable {
    var id: Int!
    var title: String!
    
    var pdfPath: String!
    var vocab: [Text]!
    var sentences: [Text]!
    
    // MARK: IO
    
    static func loadLesson(id: Int) -> Lesson? {
        guard let lessonPath = Bundle.main.path(forResource: "lesson\(id)", ofType: ".json") else { return nil }
        let lessonData = NSData.init(contentsOfFile: lessonPath)! as Data
        do {
            let lesson = try JSONDecoder().decode(Lesson.self, from: lessonData)
            return lesson
        } catch {
            return nil
        }
    }
    
    static func loadLessons() -> [Lesson] {
        var lessons: [Lesson] = []
        for id in 1...5 {
            if let lesson = loadLesson(id: id) {
                lessons.append(lesson)
            }
        }
        return lessons
    }
}
