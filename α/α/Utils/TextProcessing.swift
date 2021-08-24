//
//  TextProcessing.swift
//  α
//
//  Created by Sola on 2021/8/24.
//  Copyright © 2021 Sola. All rights reserved.
//

import Foundation

// MARK: - Text Processing

struct Tokenizer {
    let punctuations = ",.·;?!"
    
    func tokenize(string: String, withSeparatorsKept shouldKeepSeparators: Bool = true) -> [String] {
        let separators = punctuations + " "
        let separatorsToKeep = shouldKeepSeparators ? punctuations : ""
        
        return string.split(with: separators, byKeeping: separatorsToKeep)
    }
}
