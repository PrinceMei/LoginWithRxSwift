//
//  ViewController.swift
//  LoginWithRx
//
//  Created by HJTTF on 2016/11/29.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    func bind() {
        
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map{ $0.characters.count >= 5 }
            .shareReplay(1)
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map{ $0.characters.count >= 5 }
            .shareReplay(1)
        let registerButtonTap = registerButton.rx.tap
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) {
            $0 && $1
        }.shareReplay(1)
        
        
        usernameValid
            .bindTo( usernameLabel.rx.isHidden )
            .addDisposableTo(disposeBag)
        usernameValid
            .bindTo(passwordTextField.rx.isEnabled)
            .addDisposableTo(disposeBag)
        
        passwordValid
            .bindTo( passwordLabel.rx.isHidden )
            .addDisposableTo(disposeBag)
        everythingValid
            .bindTo(registerButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
        
        
        
        
    }

}

