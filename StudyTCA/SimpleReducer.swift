//
//  SimpleReducer.swift
//  StudyTCA
//
//  Created by KANO on 10/2/23.
//

import Foundation
import ComposableArchitecture
import Alamofire

struct SimpleReducer: Reducer {
    
    struct State: Equatable {
        var userList:Users = []
        var erroMsg:String?
    }
    
    enum Action {
        case loadUsers
        case responseUsers(Result<Users, AFError>)
    }
    
    @Dependency(\.simpleClient) var userlistClient
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
        switch action {
        case .loadUsers:
            
            return .run { send in
                await send(.responseUsers(try await self.userlistClient.fetchAll()))
            }
        case .responseUsers(.success(let response)):
            state.userList = response
            return .none
        case .responseUsers(.failure(let error)):
            state.userList = []
            state.erroMsg = error.errorDescription
            
            
        }
        
    }
    
    
    }
}

