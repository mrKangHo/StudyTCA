//
//  SimpleViewController.swift
//  StudyTCA
//
//  Created by KANO on 10/1/23.
//

import UIKit
import ComposableArchitecture
import Combine
import PinLayout



class SimpleViewController: UIViewController, BindableView {
    typealias ReducerType = SimpleReducer
    
    var viewStore: ViewStoreOf<SimpleReducer>
    var cancellables: Set<AnyCancellable> = []

    
    
    private var btnLoad:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("불러오기", for: .normal)
        return btn
        
    }()
    
    private var lbData:UITextView = {
        let label = UITextView()
        label.isEditable = false
        return label    }()

    
    
    init(_ store:StoreOf<SimpleReducer>) {
        self.viewStore = ViewStore(store, observe: {$0})
        super.init(nibName: nil, bundle: nil)
        self.bind(self.viewStore)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(btnLoad)
        self.view.addSubview(lbData)
        
        self.btnLoad.addTarget(self, action: #selector(btnPress), for: .touchUpInside)
        self.btnLoad.pin.left().top(100).right().height(50)
        self.lbData.pin.left().top(to: self.btnLoad.edge.bottom).right().bottom()

        // Do any additional setup after loading the view.
    }
    
    func bind(_ viewStore: ViewStoreOf<SimpleReducer>) {
        
        viewStore.publisher.userList.filter{$0.isEmpty == false}.sink { users in
            
            print(users)
            self.lbData.text = users.description
            
        }.store(in: &self.cancellables)
        
        viewStore.publisher.erroMsg.filter{$0?.isEmpty == false}.sink { error in
            self.lbData.text = error
        }.store(in: &self.cancellables)
        
        
    }
    

    @objc func btnPress() {
        self.viewStore.send(.loadUsers)
    }
    

}
