//
//  SimpleClient.swift
//  StudyTCA
//
//  Created by KANO on 10/2/23.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay
import Alamofire

struct SimpleClient {
    var fetchAll: @Sendable () async throws -> Result<Users, AFError>
    var fetchItem: @Sendable (_ id:String) async throws -> User
}


//extension SimpleClient : TestDependencyKey {
//    static var previewValue = Self(fetchAll: { .mock},
//                                   fetchItem: { userId in .mock})
//    static var testValue = Self(fetchAll: unimplemented("\(Self.self).Users"),
//                                fetchItem: unimplemented("\(Self.self).User"))
//}

extension SimpleClient : DependencyKey {
    
    static var liveValue = Self(fetchAll: {
        let url = URL(string: "https://6512719eb8c6ce52b3959f88.mockapi.io/Users")
        let result = try await NetworkManager.shared.fetchData(from: url!, Users.self)
        
//        let (data, _) = try await URLSession.shared.data(from: url!)
        return result
    }, fetchItem: { userId in
        let url = URL(string: "https://6512719eb8c6ce52b3959f88.mockapi.io/Users/\(userId)")
        let (data, _) = try await URLSession.shared.data(from: url!)
        return try JSONDecoder().decode(User.self, from: data)
    })
}

extension DependencyValues {
    
    var simpleClient : SimpleClient {
        get { self[SimpleClient.self]}
        set { self[SimpleClient.self] = newValue}
    }
}

extension User {
    static let mock = Self(createdAt: "", name: "", avatar: "", id: "")
}

extension Users {
    static let mock = Self([User.mock])
}

