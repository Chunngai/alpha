////
////  Lesson.swift
////  α
////
////  Created by Sola on 2021/1/16.
////  Copyright © 2021 Sola. All rights reserved.
////
//
//import Foundation
//
//struct Lesson: Codable {
//    var id: Int!
//    var title: String!
//    var vocab: [Word]?
//    var sentences: [Sentence]?
//    var reading: Reading?
//    
//    var pdfName: String {
//        return "lesson\(id!)"
//    }
//    
//    var lastModifiedDate: Date?
//}
//
//struct TextBook: Codable {
//    // MARK: IO
//    
//    private static let rootUrl: String = "http://37y2o07669.qicp.vip/static/file/lessons"
//    
//    private static func localLesson(_ lessonId: Int) -> Lesson? {
//        do {
//            let fileURL = try FileManager.default
//                .url(
//                    for: .applicationSupportDirectory,
//                    in: .userDomainMask,
//                    appropriateFor: nil,
//                    create: false
//            )
//                .appendingPathComponent("lesson\(lessonId).json")
//            
//            let data = try Data(contentsOf: fileURL)
//            let lesson = try JSONDecoder().decode(Lesson.self, from: data)
//            return lesson
//        } catch {
////            print(error)
//            return nil
//        }
//    }
//    
//    private static func isJsonUpdated(forLesson lessonId: Int, since: Date) -> Bool {
//        return false
//    }
//    
//    private static func requestRemotePdfForLesson(_ lessonId: Int, completion: @escaping (_ pdf: Data?) -> Void) {
//        let jsonUrl = URL(string: "\(rootUrl)/lesson\(lessonId).pdf")!
//        
//        let task = URLSession.shared.dataTask(with: jsonUrl) { (data, response, error) in
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//            
//            completion(data)
//        }
//        task.resume()
//    }
//    
//    private static func requestRemoteJsonForLesson(_ lessonId: Int, completion: @escaping (_ json: String?, _ date: Date?) -> Void) {
//        let jsonUrl = URL(string: "\(rootUrl)/lesson\(lessonId).json")!
//        
//        let task = URLSession.shared.dataTask(with: jsonUrl) { (data, response, error) in
//            guard let data = data else {
//                completion(nil, nil)
//                return
//            }
//            
//            var date: Date? = nil
//            if let response = response as? HTTPURLResponse {
//                if let dateString = response.allHeaderFields["Last-Modified"] as? String {
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
//                    date = dateFormatter.date(from: dateString)
//                }
//            }
//            
//            completion(String(data: data, encoding: .utf8), date)
//        }
//        task.resume()
//    }
//    
//    private static func save(pdf: Data, forLesson lessonId: Int) {
//        do {
//            let fileURL = try FileManager.default
//                .url(
//                    for: .applicationSupportDirectory,
//                    in: .userDomainMask,
//                    appropriateFor: nil,
//                    create: true
//            )
//                .appendingPathComponent("lesson\(lessonId).pdf")
//
//            try pdf.write(to: fileURL)
//        } catch {
//            print(error)
//        }
//    }
//    
//    private static func save(lesson: Lesson, forLesson lessonId: Int) {
//        do {
//            let fileURL = try FileManager.default
//                .url(
//                    for: .applicationSupportDirectory,
//                    in: .userDomainMask,
//                    appropriateFor: nil,
//                    create: true
//            )
//                .appendingPathComponent("lesson\(lessonId).json")
//
//            try JSONEncoder()
//                .encode(lesson)
//                .write(to: fileURL)
//        } catch {
//            print(error)
//        }
//    }
//    
//    static func loadLesson(id: Int, completion: @escaping (_ lesson: Lesson?) -> Void) {
////        if let localLesson = localLesson(id) {
////            if isJsonUpdated(forLesson: id, since: localLesson.lastModifiedDate) {
////                // Parses the local json.
////
////                // Return.
////            }
////        } else {
//            requestRemotePdfForLesson(id) { (pdf) in
//                if let pdf = pdf {
//                    save(pdf: pdf, forLesson: id)
//                }
//            }
//            requestRemoteJsonForLesson(id) { (json, date) in
//                if let json = json {
//                    let lessonData = json.data(using: .utf8)!
//                    do {
//                        var lesson = try JSONDecoder().decode(Lesson.self, from: lessonData)
//                        
//                        lesson.lastModifiedDate = date
//                        save(lesson: lesson, forLesson: id)
//                        
//                        completion(lesson)
//                    } catch {
//                        completion(nil)
//                    }
//                }
//            }
////        }
//    }
//    
//    static func loadLessons() -> [Lesson] {
//        var lessons: [Lesson] = []
//        for id in 1...50 {
//            loadLesson(id: id) { (lesson) in
//                if let lesson = lesson {
//                    lessons.append(lesson)
//                }
//            }
//        }
//        return lessons
//    }
//}
