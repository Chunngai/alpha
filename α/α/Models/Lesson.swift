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
    
    // MARK: - Init
    
    // MARK: - IO
    
    // TODO: Load from disk
    static func loadLessons() -> [Lesson] {
//        var lessons: [Lesson] = []
        
//        for i in 1...50 {
//            lessons.append(Lesson(id: i, title: "Lesson" + String(i), pdfPath: "", vocab: [], sentences: []))
//        }
//
//        lessons[0] = Lesson(id: 1, title: "Lesson 1", pdfPath: "", vocab: [], sentences: [])
//        lessons[1] = Lesson(id: 2, title: "Lesson 2", pdfPath: "", vocab: [], sentences: [])
//        lessons[2] = Lesson(id: 3, title: "Lesson 3", pdfPath: "", vocab: [
//            Text(greek: "γράφω", english: "write, draw [cf. autograph]"),
//            Text(greek: "ἐθέλω", english: "(+ infinitive) be willing (to), wish (to)")
//        ], sentences: [
//            Text(greek: "παιδεύεις καὶ οὐ κλέπτεις.", english: "You teach and you don't steal."),
//            Text(greek: "μὴ γράφε· σπεῦδε φυλάττειν.", english: "Don't write: hasten to protect.")
//        ])
//        lessons[3] = Lesson(id: 4, title: "Lesson 4", pdfPath: "", vocab: [
//            Text(greek: "v1", english: "1"),
//            Text(greek: "v2", english: "2")
//        ], sentences: [
//            Text(greek: "s1", english: "1"),
//            Text(greek: "s2", english: "2")
//        ])
//        lessons[4] = Lesson(id: 5, title: "Lesson 4", pdfPath: "", vocab: [
//            Text(greek: "v3", english: "3"),
//            Text(greek: "v4", english: "4")
//        ], sentences: [
//            Text(greek: "s3", english: "3"),
//            Text(greek: "s4", english: "4")
//        ])
//        lessons[5] = Lesson(id: 6, title: "Lesson 4", pdfPath: "", vocab: [
//            Text(greek: "v5", english: "5"),
//            Text(greek: "v6", english: "6")
//        ], sentences: [
//            Text(greek: "s5", english: "5"),
//            Text(greek: "s6", english: "6")
//        ])
        
//        guard let path = Bundle.main.url(forResource: "lessons", withExtension: "txt") else { return [] }
//
//        let data = try! Data(contentsOf: path)
//        if let text = String(data: data, encoding: .utf8) {
//            let linesSubSequences = text.split(separator: "\n")
//            var lines: [String] = []
//            for i in 0..<linesSubSequences.count {
//                lines.append(String(linesSubSequences[i]))
//            }
//
//            var lesson = Lesson(id: nil, pdfPath: "", vocab: [], sentences: [])
//            while !lines.isEmpty {
//                var line = lines.removeFirst()
//
//                if line.contains("<LESSON id=") {
//                    lesson.id = Int(Lesson.getRegexResult(text: line, pattern: "<LESSON id=\"(\\d+)\">", group: 1)!)
//                    continue
//                }
//                if line.contains("</LESSON>") {
//                    lessons.append(lesson)
//                    lesson = Lesson(id: nil, pdfPath: "", vocab: [], sentences: [])
//                    continue
//                }
//
//                if line.contains("<VOCAB>") {
//                    while true {
//                        line = lines.removeFirst()
//                        if line.trimmingCharacters(in: .whitespaces) == "<EXPLANATION>" {
//                            let explanation = lines.removeFirst().trimmingCharacters(in: .whitespaces)
//
//                            var text = lesson.vocab.removeLast()
//                            text = Text(greek: text.greek, english: text.english, explanation: explanation)
//                            lesson.vocab.append(text)
//
//                            lines.removeFirst()
//                            continue
//                        }
//                        if line.trimmingCharacters(in: .whitespaces) == "" {
//                            continue
//                        }
//                        if line == "</VOCAB>" {
//                            break
//                        }
//                        let el = line.trimmingCharacters(in: [" "])
//
//                        line = lines.removeFirst()
//                        let en = line.trimmingCharacters(in: [" "])
//
//                        lesson.vocab.append(Text(greek: el, english: en))
//                    }
//                    continue
//                }
//
//                if line.contains("<SENTENCES>") {
//                    while true {
//                        line = lines.removeFirst()
//                        if line.trimmingCharacters(in: .whitespaces) == "" {
//                            continue
//                        }
//                        if line == "</SENTENCES>" {
//                            break
//                        }
//                        let el = line.trimmingCharacters(in: [" "])
//
//                        line = lines.removeFirst()
//                        let en = line.trimmingCharacters(in: [" "])
//
//                        lesson.sentences.append(Text(greek: el, english: en))
//                    }
//                    continue
//                }
//            }
//        }
//
//        guard let path_ = Bundle.main.url(forResource: "lessonTitles", withExtension: "txt") else { return [] }
//        let data_ = try! Data(contentsOf: path_)
//        if let text = String(data: data_, encoding: .utf8) {
//            let linesSubSequences = text.split(separator: "\n")
//            var lines: [String] = []
//            for i in 0..<linesSubSequences.count {
//                lines.append(String(linesSubSequences[i]))
//            }
//
//            for i in 0..<lines.count {
//                if i < lessons.count {
//                    lessons[i].title = lines[i]
//                } else {
//                    var lesson = Lesson(id: i+1, pdfPath: "", vocab: [], sentences: [])
//                    lesson.title = lines[i]
//                    lessons.append(lesson)
//                }
//            }
//        }
        
        guard let path = Bundle.main.path(forResource: "lessons", ofType: ".json") else { return [] }
        let localData = NSData.init(contentsOfFile: path)! as Data
        do {
            let lessonsModel = try JSONDecoder().decode(LessonsModel.self, from: localData)
            var lessons: [Lesson] = []
            for lesson in lessonsModel.lessons {
                lessons.append(lesson)
            }
            return lessons
        } catch {
            return []
        }        
    }
    
    // MARK: - Utils
    
//    static func getRegexResult(text: String, pattern: String, group: Int) -> String? {
//        let pattern = pattern
//        let regex = try? NSRegularExpression(pattern: pattern, options: [])
//        let res = regex?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count))
//
//        if let res = res {
//            let dataCountRange = res.range(at: group)
//            let startIndex = text.index(text.startIndex, offsetBy: dataCountRange.location)
//            let endIndex = text.index(text.startIndex, offsetBy: dataCountRange.location + dataCountRange.length)
//            return String(text[startIndex..<endIndex])
//        }
//
//        return nil
//    }
}

struct LessonsModel: Codable {
    var lessons: [Lesson]
}
