//
//  ViewController.swift
//  LoginWithRx
//
//  Created by tiantengfei on 2016/11/29.
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
        
        let viewModel = RegisterViewModel(input:
            (username: usernameTextField.rx.text.orEmpty.asObservable(),
             password: passwordTextField.rx.text.orEmpty.asObservable(),
             repeatPassword: repeatPasswordTextField.rx.text.orEmpty.asObservable(),
             registerTaps: registerButton.rx.tap.asObservable()),
             service: ValidationService.instance)
        
        viewModel.usernameUsable
            .bindTo(usernameLabel.rx.validationResult)
            .addDisposableTo(disposeBag)
        
    }

}

