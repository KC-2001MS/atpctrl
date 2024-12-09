//
//  Notifications.swift
//  atpctrl
//
//  Created by 茅根啓介 on 2024/12/07.
//

import ArgumentParser
import ATProtoKit
import SwiftLI

// 
struct Notifications: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "notifications",
        abstract: "View the notifications",
        discussion: """
        Displays a list of notifications in the logged-in account.
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
        //Get a list of notifications
        let result  = try? await atProto.listNotifications(priority: nil)
        let notifications = result?.notifications ?? []
        
        Group {
            Text("Notifications")
                .forgroundColor(.blue)
                .bold()
                .newLine()
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
            
            if notifications.isEmpty {
                Text("No Notifications")
                    .forgroundColor(.red)
                    .newLine()
            } else {
                for notification in notifications {
                    Group {
                        if let deisplayName = notification.notificationAuthor.displayName, !deisplayName.isEmpty {
                            Text(deisplayName)
                        } else {
                            Text("No display Name")
                        }
                        
                        Text("[\(notification.notificationAuthor.actorHandle)]")
                            .forgroundColor(.eight_bit(244))
                        
                        Spacer()
                        
                        Text(notification.notificationReason.rawValue)
                    }
                    .newLine()
                }
            }
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
        }
        .render()
    }
}
