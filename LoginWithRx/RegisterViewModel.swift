//
//  RegisterViewModel.swift
//  LoginWithRx
//
//  Created by tiantengfei on 2016/11/29.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewModel: NSObject {
    let usernameUsable: Observable<Result>
    let passwordUsable: Observable<Result>
    let repeatPasswordUsable: Observable<Result>
    let registerButtonEnabled: Observable<Bool>
    
    let registerResult: Observable<Result>
    
    init(input: (username: Observable<String>, password: Observable<String>, repeatPassword: Observable<String>, registerTaps: Observable<Void>),
         service: ValidationService) {
        usernameUsable = input.username
            .flatMapLatest{ username in
                return service.validateUsername(username)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.failed(message: "username检测出错"))
            }
            .shareReplay(1)

        passwordUsable = input.password
            .map { password in
                return service.validatePassword(password)
            }
            .shareReplay(1)
        
        repeatPasswordUsable = Observable.combineLatest(input.password, input.repeatPassword) {
                return service.validateRepeatedPassword($0, repeatedPasswordword: $1)
            }
            .shareReplay(1)
        
        registerButtonEnabled = Observable.combineLatest(usernameUsable, passwordUsable, repeatPasswordUsable) {
            (username, password, repeatPassword) in
                username.isValid && password.isValid && repeatPassword.isValid
            }
            .distinctUntilChanged()
            .shareReplay(1)
        
        let usernameAndPassword = Observable.combineLatest(input.username, input.password) {
            ($0, $1)
        }
        
        registerResult = input.registerTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { (username, password) in
                return service.register(username, password: password)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.failed(message: "注册出错"))
            }
            .shareReplay(1)
    }
        
}

