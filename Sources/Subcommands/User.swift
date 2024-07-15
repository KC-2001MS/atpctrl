//
//  User.swift
//
//
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit
import SwiftLI

struct User: AsyncParsableCommand {
    @Argument(help: "The user's handle you want to display") var text: String = ""
    
    static var configuration = CommandConfiguration(
        commandName: "user",
        abstract: "View user profile",
        discussion: """
        Displays user profiles for the specified handle. If blank, your own profile will be displayed.
        """,
        version: "0.0.2",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        let (atProto, session) = try await restoreLogin()
        //Retrieve user profiles
        let result  = try await atProto.getProfile(text.isEmpty ? session.handle : text)
        
        Group{
            Text("Profile")
                .forgroundColor(.blue)
                .bold()
                .newLine()
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
            
            Group {
                Text(result.displayName ?? "No Display Name")
                
                Text("[\(result.actorHandle)]")
                    .forgroundColor(.eight_bit(244))
            }
            .newLine()
            
            Text(result.description ?? "")
                .newLine(result.description != nil)
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
        }.render()
    }
}

