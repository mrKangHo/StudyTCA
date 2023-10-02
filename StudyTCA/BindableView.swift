//
//  BindableView.swift
//  StudyTCA
//
//  Created by KANO on 10/2/23.
//

import ComposableArchitecture
import Combine


protocol BindableView : AnyObject {
    
    associatedtype ReducerType: Reducer
    
    var viewStore:ViewStoreOf<ReducerType> { get set }
    var cancellables:Set<AnyCancellable> { get set }

    func bind(_ viewStore:ViewStoreOf<ReducerType>)
}
