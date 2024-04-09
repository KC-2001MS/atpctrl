//
//  Lists.swift
//  
//  
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit

struct Lists: AsyncParsableCommand {
    @OptionGroup var account: Account
    
    static var configuration = CommandConfiguration(
        commandName: "lists",
        abstract: "View a list of SNS user lists.",
        discussion: """
        Displays a list of users registered under the logged-in account.
        """,
        version: "0.0.1",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        //Login process
        let config = ATProtocolConfiguration(handle: account.handle, appPassword: account.password)
        var atProto: ATProtoKit
        let userSesstion: UserSession
        switch try await config.authenticate() {
        case .success(let result):
            atProto = ATProtoKit(session: result)
            userSesstion = result
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
        //Get a list of listings
        let result  = try await atProto.getLists(from: userSesstion.sessionDID)
        let lists: Array<GraphListView>
        switch result {
        case .success(let success):
            lists = success.lists
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
        //Display process
        print("User Lists")
        print("---------------------------------------------------------")
        for list in lists {
            print(list.name)
        }
        print("---------------------------------------------------------")
    }
}
