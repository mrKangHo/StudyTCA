//
//  SimpleReducer.swift
//  StudyTCA
//
//  Created by KANO on 10/2/23.
//

import Foundation
import ComposableArchitecture

struct SimpleReducer: Reducer {
    
    struct State: Equatable {
        var userList:Users = []
    }
    
    enum Action: Equatable {
        case loadUsers
        case responseUsers(TaskResult<Users>)
    }
    
    @Dependency(\.simpleClient) var userlistClient
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
        switch action {
        case .loadUsers:
            
            return .run { send in
                await send(.responseUsers(TaskResult{ try await self.userlistClient.fetchAll()}))
            }
        case .responseUsers(.success(let response)):
            state.userList = response
            return .none
        case .responseUsers(.failure(let error)):
            state.userList = []
            return .none
        }
        
    }
    
}

