//
//  Login.swift
//
//  
//  Created by Keisuke Chinone on 2024/06/08.
//


import ArgumentParser
import ATProtoKit
import SwiftLI

struct Login: AsyncParsableCommand {
    @OptionGroup var account: Account
    //MARK: configuration
    static var configuration = CommandConfiguration(
        commandName: "login",
        abstract: "Log in to the account you own.",
        discussion: """
        To execute other commands, you must log in with this command beforehand.
        The login is complete when you see “Successfully logged in.”
        """,
        version: "0.0.2",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        let config = ATProtocolConfiguration(handle: account.handle, appPassword: account.password)
        switch try await config.authenticate() {
        case .success(_):
            Text("Successfully logged in.")
                .forgroundColor(.green)
                .italic()
                .newLine()
                .render()
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
        
        let accountData = AccountData(domain: account.domain, handle: account.handle, password: account.password)
        
        do {
            // FIXME: Currently, there is a problem with saved account information being stored in plain text.
            try FileHelper.saveLoginData(accountData)
        } catch {
            Text("Failed to save account information.")
                .forgroundColor(.red)
                .italic()
                .newLine()
                .render()
        }
    }
}
