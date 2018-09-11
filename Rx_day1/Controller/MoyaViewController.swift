//
//  MoyaViewController.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/9/11.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import Result
import RxGesture

class MoyaViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //获取数据
//        DouBanProvider.rx.request(.channels)
//            .subscribe { event in
//                switch event {
//                case let .success(response):
//                    //数据处理
//                    let str = String(data: response.data, encoding: String.Encoding.utf8)
//                    print("返回的数据是：", str ?? "")
//                case let .error(error):
//                    print("数据请求失败!错误原因：", error)
//                }
//            }.disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
