//
//  LessonExt.swift
//  α
//
//  Created by Sola on 2021/8/21.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element == Lesson {
    var vocab: [Word] {
        var vocab:[Word] = []
        for lesson in self {
            vocab.append(contentsOf: lesson.vocab ?? [])
        }
        return vocab
    }
}
