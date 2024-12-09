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
    @Argument(help: "The user's handle you want to display") var text: String = ""
    
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
        let atProto: ATProtoKit
        
        do {
            atProto = try await restoreLogin()
        } catch {
            LoginErrorView().render()
            return
        }
        
        let profile  = try await atProto.getProfile(text.isEmpty ? atProto.session?.handle ?? text : text)
        //FIXME: I do not know how to specify the DID for the argument of the getLists function. It does not work.
        let result  = try await atProto.getLists(from: profile.actorDID)
        let lists = result.lists
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
            
            for list in lists {
                Text(list.name)
            }
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
        }
        .render()
    }
}
