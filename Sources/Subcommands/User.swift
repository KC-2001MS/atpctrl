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
        let myAccount: ActorProfileViewDetailed
        switch result {
        case .success(let success):
            myAccount = success.actorProfileView
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
        
        ProfileView(account: myAccount).render()
    }
}

struct ProfileView: View {
    let account: ActorProfileViewDetailed
    
    var body: [View] {
        Text("Profile")
            .forgroundColor(.blue)
            .bold()
            .newLine()
        
        HDivider(10)
            .lineStyle(.double_line)
            .forgroundColor(.eight_bit(244))
            .newLine()
        
        Group {
            Text(account.displayName ?? "No Display Name")
            
            Text("[\(account.actorHandle)]")
                .forgroundColor(.eight_bit(244))
        }
        .newLine()
        
        Text(account.description ?? "")
            .newLine(account.description != nil)
        
        HDivider(10)
            .lineStyle(.double_line)
            .forgroundColor(.eight_bit(244))
            .newLine()
    }
}
