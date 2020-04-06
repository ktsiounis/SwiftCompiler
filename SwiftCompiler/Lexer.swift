//
//  Lexer.swift
//  SwiftCompiler
//
//  Created by Dinos Tsiounis on 6/4/20.
//  Copyright © 2020 Konstantinos Tsiounis. All rights reserved.
//

import Foundation

class Lexer: LexerParser {
    private let input: String
    private var position: String.Index
    enum Error: Swift.Error {
        case invalidCharacter(Character)
    }
    
    init(input: String) {
        self.input = input
        self.position = self.input.startIndex
    }
    
    private func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }
    
    private func advance() {
        precondition(position < input.endIndex, "Cannot advance past the endIndex")
        position = input.index(after: position)
    }
    
    func lex() throws -> [Token] {
        var tokens = [Token]()
        
        while let nextCharacter = peek() {
            
            switch nextCharacter {
            case "0"..."9":
                let value = getNumber()
                tokens.append(.number(value))
            case "+":
                tokens.append(.plus)
                advance()
            case " ":
                advance()
            default:
                throw Lexer.Error.invalidCharacter(nextCharacter)
            }
            
        }
        return tokens
    }
    
    private func getNumber() -> Int {
        var value = 0
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0"..."9":
                let digitValue = Int(String(nextCharacter))!
                value = 10*value + digitValue
                advance()
            default:
                return value
            }
        }
        return value
    }
    
    
}
