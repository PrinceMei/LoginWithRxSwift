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
        viewModel.usernameUsable
            .bindTo(passwordTextField.rx.inputEnabled)
            .addDisposableTo(disposeBag)
        
        viewModel.passwordUsable
            .bindTo(passwordLabel.rx.validationResult)
            .addDisposableTo(disposeBag)
        viewModel.passwordUsable
            .bindTo(repeatPasswordTextField.rx.inputEnabled)
            .addDisposableTo(disposeBag)
        
        viewModel.repeatPasswordUsable
            .bindTo(repeatPasswordLabel.rx.validationResult)
            .addDisposableTo(disposeBag)
        
        viewModel.registerButtonEnabled
            .subscribe(onNext: { [weak self] valid in
                self?.registerButton.isEnabled = valid
                self?.registerButton.alpha = valid ? 1.0 : 0.5
            })
            .addDisposableTo(disposeBag)
        
        viewModel.registerResult
            .subscribe(onNext: { [weak self] result in
                switch result {
                case let .ok(message):
                    self?.showAlert(message: message)
                case .empty:
                    self?.showAlert(message: "")
                case let .failed(message):
                    self?.showAlert(message: message)
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func showAlert(message: String) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }

}

