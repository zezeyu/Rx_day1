//
//  RefreshService.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/12/19.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RefreshService {
    
    //获取随机数据
    func getRandomResult() -> Driver<[String]> {
        print("正在请求数据......")
        let items = (0 ..< 15).map {_ in
            "随机数据\(Int(arc4random()))"
        }
        let observable = Observable.just(items)
        return observable.delay(1, scheduler: MainScheduler.instance).asDriver(onErrorDriveWith: Driver.empty())
    }
}
