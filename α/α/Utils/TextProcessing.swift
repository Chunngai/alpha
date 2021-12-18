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
    
    func tokenize(string: String, withSeparatorsKept shouldKeepSeparators: Bool = true, lowercase: Bool = false) -> [String] {
        let separators = punctuations + " "
        let separatorsToKeep = shouldKeepSeparators ? punctuations : ""
        
        var tokens = string.split(with: separators, byKeeping: separatorsToKeep)
        if lowercase {
            tokens = tokens.compactMap({ (token) -> String in
                token.lowercased()
            })
        }
        return tokens
    }
}
