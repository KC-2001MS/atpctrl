//
//  File.swift
//  
//  
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit

struct Account: ParsableArguments {
    @Argument(help: "Domain of SNS service")
    var domain: String = "bsky.app"
    
    @Argument(help: "Account Handle")
    var handle: String
    
    @Argument(help: "Account password")
    var password: String
}

struct AccountData: Codable, Equatable {
    var domain: String
    
    var handle: String
    
    var password: String
    
    init(
        domain: String,
        handle: String,
        password: String
    ) {
        self.domain = domain
        self.handle = handle
        self.password = password
    }
    
    static func == (lhs: AccountData, rhs: AccountData) -> Bool {
        return lhs.domain == rhs.domain && lhs.handle == rhs.handle && lhs.password == rhs.password
    }
}
