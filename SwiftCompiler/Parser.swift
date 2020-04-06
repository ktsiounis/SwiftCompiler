//
//  Parser.swift
//  SwiftCompiler
//
//  Created by Dinos Tsiounis on 6/4/20.
//  Copyright © 2020 Konstantinos Tsiounis. All rights reserved.
//

import Foundation

class Parser: LexerParser {
    let tokens: [Token]
    var position = 0
    
    enum Error: Swift.Error {
        case unexpectedEndOfInput
        case invalidToken(Token)
    }
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        position += 1;
        return token
    }
    
    func getNumber() throws -> Int {
        guard let token = getNextToken() else {
            throw Parser.Error.unexpectedEndOfInput
        }
        switch token {
        case .number(let value):
            return value
        case .plus:
            throw Parser.Error.invalidToken(token)
        }
    }
    
    func parse() throws -> Int {
        var value = try getNumber()
        
        while let token = getNextToken() {
            switch token {
            case .plus:
                let nextNumber = try getNumber()
                value += nextNumber
            case .number:
                throw Parser.Error.invalidToken(token)
            }
        }
        return value
    }
    
}
