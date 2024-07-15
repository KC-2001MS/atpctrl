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

@Suite("General Commands Testing",.tags(.general))
struct GeneralCommandsTest {
    @Suite(.tags(.executable))
    struct Executable {
        @Test("Can stored login information be loaded?")
        func loadLoginInformation() throws {
            try? FileHelper.saveLoginData(AccountData(domain: "", handle: "", password: ""))
            let _ = try #require(try? FileHelper.loadLoginData())
        }
    }
}

@Suite("Feeds Command Testing",.tags(.feeds))
struct FeedsCommandTest {
    @Suite(.tags(.executable))
    struct Executable {
        @Test("Does the Feeds command work?")
        func FeedsWorks() throws {
            var feeds = Feeds()
            
            #require(try? feeds.run())
        }
    }
}

@Suite("Lists Command Testing",.tags(.lists))
struct ListsCommandTest {
    @Suite(.tags(.executable))
    struct Executable {
        @Test("Does the Lists command work?")
        func ListsWorks() throws {
            var lists = Lists()
            
            #require(try? lists.run())
        }
    }
}

@Suite("Login Command Testing",.tags(.login))
struct LoginCommandTest {
    @Suite(.tags(.executable))
    struct Executable {
        @Test("Can login information be saved?")
        func saveLoginDataWorks() throws {
            let account =  AccountData(domain: "test", handle: "test", password: "test")
            
            try #require(try? FileHelper.saveLoginData(account))
        }
    }
    
    @Suite(.tags(.normalBehavior))
    struct NormalBehavior {
        @Test("Is the saved value equal to the loaded value?")
        func consistentSaveAndLoad() throws {
            let account = AccountData(domain: "test", handle: "test", password: "test")
            
            try? FileHelper.saveLoginData(account)
            
            let loadedAccount = try? FileHelper.loadLoginData()
            
            #expect(account == loadedAccount)
        }
        
        @Test("Is the file deleted successfully?")
        func deleteLoginInformation() throws {
            try? FileHelper.deleteLoginData()
            
            #expect(!FileHelper.fileManager.fileExists(atPath: FileHelper.fileURL.path))
        }
    }
}

@Suite("MutesAccounts Command Testing",.tags(.mutesAccounts))
struct MutesAccountsCommandTest {
    @Suite(.tags(.executable))
    struct Executable {
        @Test("Does the MutesAccounts command work?")
        func MutesAccountsWorks() throws {
            var feeds = MutesAccounts()
            
            #require(try? feeds.run())
        }
    }
}

@Suite("Post Command Testing",.tags(.post))
struct PostAccountsCommandTest {
    @Suite(.tags(.executable))
    struct Executable {
        @Test("Does the Post command work?")
        func PostWorks() throws {
            var feeds = Post()
            
            #require(try? feeds.run())
        }
    }
}

@Suite("User Command Testing",.tags(.user))
struct UserAccountsCommandTest {
    @Suite(.tags(.executable))
    struct Executable {
        @Test("Does the User command work?")
        func UserWorks() throws {
            var feeds = User()
            
            #require(try? feeds.run())
        }
    }
}

@Suite("Users Command Testing",.tags(.users))
struct UsersAccountsCommandTest {
    @Suite(.tags(.executable))
    struct Executable {
        @Test("Does the Users command work?")
        func UsersWorks() throws {
            var feeds = Users()
            
            #require(try? feeds.run())
        }
    }
}
