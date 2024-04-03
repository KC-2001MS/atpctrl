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
