//
//  SimpleValidationViewController.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/7/31.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let minimalUsernameLength = 5
let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {

    
    @IBOutlet weak var usernameOutlet: UITextField!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBOutlet weak var doSomethingOutlet: UIButton!
    //用户名
    @IBOutlet weak var usernameValidOutlet: UILabel!
    //密码
    @IBOutlet weak var passwordValidOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        // 用户名是否有效
        let usernameValid = usernameOutlet.rx.text.orEmpty
            // 用户名 -> 用户名是否有效
            .map { $0.count >= minimalUsernameLength }
            .shareReplay(1)
        // 密码是否有效
        let passwordValid = passwordOutlet.rx.text.orEmpty
            // 密码 -> 密码是否有效
            .map { $0.count >= minimalPasswordLength}
            .shareReplay(1)
        // 所有输入是否有效
        let everythingValid = Observable.combineLatest(
             usernameValid,
             passwordValid
            ){$0 && $1} // 取用户名和密码同时有效
            .shareReplay(1)
        
        ///用户名是否有效->密码输入框是否可用
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        ///用户名是否有效->用户名提示语是否隐藏
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        // 密码是否有效 -> 密码提示语是否隐藏
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] in self?.showAlert() })
            .disposed(by: disposeBag)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(){
        
    }
    
//    @IBAction func buttonAction(_ sender: UIButton) {
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
