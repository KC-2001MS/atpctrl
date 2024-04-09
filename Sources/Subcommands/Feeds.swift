//
//  Feeds.swift
//
//  
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit

struct Feeds: AsyncParsableCommand {
    @OptionGroup var account: Account
    
    static var configuration = CommandConfiguration(
        commandName: "feeds",
        abstract: "View a list of social networking feeds",
        discussion: """
        Returns a list of recommended feeds for the logged-in account.
        """,
        version: "0.0.1",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        //Login process
        let config = ATProtocolConfiguration(handle: account.handle, appPassword: account.password)
        var atProto: ATProtoKit
        switch try await config.authenticate() {
        case .success(let result):
            atProto = ATProtoKit(session: result)
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
        //Get a list of suggested feeds
        let result  = try await atProto.getSuggestedFeeds()
        let suggestions: Array<FeedGeneratorView>
        switch result {
        case .success(let success):
            suggestions = success.feeds
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
        //Display process
        print("Discover New Feeds")
        print("---------------------------------------------------------")
        for suggestion in suggestions {
            print(suggestion.displayName.isEmpty ? "No display Name" : suggestion.displayName)
        }
        print("---------------------------------------------------------")
    }
}
