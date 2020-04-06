//
//  main.swift
//  SwiftCompiler
//
//  Created by Dinos Tsiounis on 6/4/20.
//  Copyright © 2020 Konstantinos Tsiounis. All rights reserved.
//

import Foundation

func evaluate(input: String) {
    do {
        print("Evaluating \(input)")
        let lexer = Lexer(input: input)
        let tokens = try lexer.lex()
        print("Lexer output: \(tokens)")
        
        let parser = Parser(tokens: tokens)
        let result = try parser.parse()
        print("Parser output: \(result)")
    } catch Lexer.Error.invalidCharacter(let character) {
        print("Input contained an invalid character: \(character)")
    } catch Parser.Error.invalidToken(let token) {
        print("Invalid token during parsing \(token)")
    } catch Parser.Error.unexpectedEndOfInput {
        print("Unexpected end of input")
    } catch {
        print("An error occured \(error)")
    }
}

evaluate(input: "10 + 3 + 5")
print()
evaluate(input: "2 + 4 + asdadd")
print()
evaluate(input: "2 + 4 + 3sd3dd")

