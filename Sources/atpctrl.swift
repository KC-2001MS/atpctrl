// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import ATProtoKit

//https://100rabh.medium.com/cli-tool-in-swift-using-swift-argument-parser-subcommands-and-flags-77ee31d9ac99
@main
struct ATProtocolContorol: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "atpctrl",
        abstract: "Operate SNS with AT protocol",
        discussion: """
        A set of commands to operate SNS compliant with AT protocol
        """,
        version: "0.0.1",
        subcommands: [
            Users.self,
            Feeds.self,
            Lists.self,
            MutesAccounts.self,
            BlockedAccounts.self,
            User.self
        ],
        defaultSubcommand: User.self,
        helpNames: [.long, .short]
    )
}
