//
//  Lists.swift
//  
//  
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit
import SwiftLI

struct Lists: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "lists",
        abstract: "View a list of SNS user lists.",
        discussion: """
        Displays a list of users registered under the logged-in account.
        """,
        version: "0.0.2",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        let (atProto, session) = try await restoreLogin()
        let result  = try await atProto.getLists(from: session.sessionDID)
        let lists: Array<GraphListView>
        switch result {
        case .success(let success):
            lists = success.lists
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
        //Display process
        Group {
            Text("User Lists")
                .forgroundColor(.blue)
                .bold()
                .newLine()
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
        }
        .render()
        
        for list in lists {
            print(list.name)
        }
        
        HDivider(10)
            .lineStyle(.double_line)
            .forgroundColor(.eight_bit(244))
            .newLine()
            .render()
    }
}
