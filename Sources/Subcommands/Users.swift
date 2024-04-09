//
//  Users.swift
//
//
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit

struct Users: AsyncParsableCommand {
    @OptionGroup var account: Account
    
    @Argument(help: "String to be searched") var text: String = ""
    
    static var configuration = CommandConfiguration(
        commandName: "users",
        abstract: "View a list of logged-in SNS users",
        discussion: """
        Displays a list of users who fit the criteria. If blank, a list of recommended users is displayed.
        """,
        version: "0.0.1",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        //Login process
        let config = ATProtocolConfiguration(handle: account.handle, appPassword: account.password)
        let session: UserSession
        var atProto: ATProtoKit
        switch try await config.authenticate() {
        case .success(let result):
            atProto = ATProtoKit(session: result)
            session = result
        case .failure(_):
            throw(RuntimeError(""))
        }
        //Get account list
        let users: Array<ActorProfileView>
        if text.isEmpty {
            let result  = try await atProto.getSuggestedFollowsByActor(session.sessionDID)
            switch result {
            case .success(let success):
                users = success.suggestions
            case .failure(let failure):
                throw(RuntimeError("\(failure)"))
            }
        } else {
            let result  = try await atProto.searchUsers(by: text)
            switch result {
            case .success(let success):
                users = success.actors
            case .failure(let failure):
                throw(RuntimeError("\(failure)"))
            }
        }
        //Display process
        print(text.isEmpty ? "Suggested Follows" : "Search Results")
        print("---------------------------------------------------------")
        for user in users {
            if let deisplayName = user.displayName {
                print(deisplayName.isEmpty ? "No display Name" : deisplayName, terminator: "")
            } else {
                print("No display Name", terminator: "")
            }
            print("[\(user.actorHandle)]")
        }
        print("---------------------------------------------------------")
    }
}
