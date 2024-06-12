//
//  Post.swift
//  
//  
//  Created by Keisuke Chinone on 2024/06/12.
//


import ArgumentParser
import ATProtoKit
import SwiftLI
import Foundation

struct Post: AsyncParsableCommand {
    //MARK: configuration
    static var configuration = CommandConfiguration(
        commandName: "post",
        abstract: "Submit Text",
        discussion: """
        Post the text.
        Posting is complete when “Posted.” is displayed.
        """,
        version: "0.0.2",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        let (atProto, _) = try await restoreLogin()
        
        Group {
            Text("Please enter the content of your submission.")
                .bold()
                .newLine()
            
            Text(">")
                .forgroundColor(.blue)
                .blink(.default)
        }
        .render()
        
        if let text = readLine() {
            let post = await atProto.createPostRecord(text: text)
            switch post {
            case .success(_):
                Text("Posted.")
                    .forgroundColor(.blue)
                    .newLine()
                    .render()
            case .failure(let failure):
                Group {
                    Text("Submission failed.")
                        .forgroundColor(.red)
                        .newLine()
                    
                    Text("Error : \(failure)")
                        .newLine()
                }
                .render()
            }
        } else {
            Text("No text entered. Please try again.")
                .forgroundColor(.red)
                .newLine()
                .render()
        }
    }
}
