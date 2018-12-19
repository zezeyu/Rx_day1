//
//  MJRefresh+Rx.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/12/19.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MJRefresh

extension Reactive where Base: MJRefreshComponent {
    
    //正在刷新事件
    var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    //停止刷新
    var endRefreshing: UIBindingObserver<Base ,Bool> {
        return UIBindingObserver(UIElement: self.base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
 
}
