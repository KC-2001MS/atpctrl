//
//  atpctrlTests.swift
//  
//  
//  Created by Keisuke Chinone on 2024/06/11.
//


import Testing
@testable import atpctrl
import Foundation

extension Tag {
    @Tag static var general: Self
    @Tag static var blockedAccounts: Self
    @Tag static var feeds: Self
    @Tag static var lists: Self
    @Tag static var login: Self
    @Tag static var mutesAccounts: Self
    @Tag static var post: Self
    @Tag static var user: Self
    @Tag static var users: Self
    
    @Tag static var executable: Self
    @Tag static var normalBehavior: Self
}

let account: AccountData = Bundle.module.decodeJSON("account.json")

@Suite("General Commands Testing",.tags(.general))
struct GeneralCommandsTest {
    @Suite(.tags(.executable))
    struct Executable {
        @Test("Is it possible to save data in the account?")
        func saveLoginData() async throws {
            #expect(throws: Never.self) {
                try FileHelper.saveLoginData(AccountData(domain: "", handle: "", password: ""))
            }
            
            try FileHelper.deleteLoginData()
        }
        
        @Test("Can I delete data from my account?")
        func deleteLoginData() async throws {
            try FileHelper.saveLoginData(AccountData(domain: "", handle: "", password: ""))
            
            #expect(throws: Never.self) {
                try FileHelper.deleteLoginData()
            }
        }
        
        @Test("Can stored login information be loaded?")
        func loadLoginInformation() throws {
            try FileHelper.saveLoginData(AccountData(domain: "", handle: "", password: ""))
            
            #expect(throws: Never.self) {
                let _ = try FileHelper.loadLoginData()
            }
            
            try FileHelper.deleteLoginData()
        }
    }
}

@Suite("Feeds Command Testing",.tags(.feeds))
struct FeedsCommandTest {
    @Suite(.tags(.executable))
    struct Executable {
        @Test("Does the Feeds command work?")
        func FeedsWorks() async throws {
            try FileHelper.saveLoginData(account)
            
            var feeds = Feeds()
            await #expect(throws: Never.self) {
                try await feeds.run()
            }
            
            try FileHelper.deleteLoginData()
        }
    }
}

//@Suite("Lists Command Testing",.tags(.lists))
//struct ListsCommandTest {
//    @Suite(.tags(.executable))
//    struct Executable {
//        @Test("Does the Lists command work?")
//        func ListsWorks() async throws {
//            try FileHelper.saveLoginData(account)
//            
//            var lists = Lists()
//            
//            await #expect(throws: Never.self) {
//                try await lists.run()
//            }
//        }
//    }
//}

//@Suite("Login Command Testing",.tags(.login))
//struct LoginCommandTest {
//    @Suite(.tags(.executable))
//    struct Executable {
//        @Test("Can login information be saved?")
//        func saveLoginDataWorks() throws {
//            let account =  AccountData(domain: "test", handle: "test", password: "test")
//            
//            try #require(FileHelper.saveLoginData(account))
//        }
//    }
//    
//    @Suite(.tags(.normalBehavior))
//    struct NormalBehavior {
//        @Test("Is the saved value equal to the loaded value?")
//        func consistentSaveAndLoad() throws {
//            let account = AccountData(domain: "test", handle: "test", password: "test")
//            
//            try? FileHelper.saveLoginData(account)
//            
//            let loadedAccount = try? FileHelper.loadLoginData()
//            
//            #expect(account == loadedAccount)
//        }
//        
//        @Test("Is the file deleted successfully?")
//        func deleteLoginInformation() throws {
//            try? FileHelper.deleteLoginData()
//            
//            #expect(!FileHelper.fileManager.fileExists(atPath: FileHelper.fileURL.path))
//        }
//    }
//}
//
//@Suite("MutesAccounts Command Testing",.tags(.mutesAccounts))
//struct MutesAccountsCommandTest {
//    @Suite(.tags(.executable))
//    struct Executable {
//        @Test("Does the MutesAccounts command work?")
//        func MutesAccountsWorks() throws {
//            var feeds = MutesAccounts()
//            
//            try #require(feeds.run())
//        }
//    }
//}
//
//@Suite("Post Command Testing",.tags(.post))
//struct PostAccountsCommandTest {
//    @Suite(.tags(.executable))
//    struct Executable {
//        @Test("Does the Post command work?")
//        func PostWorks() throws {
//            var feeds = Post()
//            
//            try #require(feeds.run())
//        }
//    }
//}
//
//@Suite("User Command Testing",.tags(.user))
//struct UserAccountsCommandTest {
//    @Suite(.tags(.executable))
//    struct Executable {
//        @Test("Does the User command work?")
//        func UserWorks() throws {
//            var feeds = User()
//            
//            try #require(feeds.run())
//        }
//    }
//}
//
//@Suite("Users Command Testing",.tags(.users))
//struct UsersAccountsCommandTest {
//    @Suite(.tags(.executable))
//    struct Executable {
//        @Test("Does the Users command work?")
//        func UsersWorks() throws {
//            var feeds = Users()
//            
//            try #require(feeds.run())
//        }
//    }
//}
