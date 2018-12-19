//
//  ViewModel.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/12/19.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    //表格数据序列
//    let tableData:Driver<[String]>
    let tableData = Variable<[String]>([])
    
    //停止刷新s状态序列
//    let endHeaderRefreshing: Driver<Bool>
    
    let endFooterRefreshing: Driver<Bool>
    
    //ViewModel初始化（根据输入实现对应的输出）
//    init(headerRefresh: Driver<Void>) {
        //网络请求服务
//        let networkService = RefreshService()
//
//        self.tableData = headerRefresh.startWith(()).flatMapLatest{ _ in networkService.getRandomResult() }
//
//        self.endHeaderRefreshing = self.tableData.map{ _ in true}
//    }
    init(footerRefresh: Driver<Void>,
         dependency: (
        disposeBag:DisposeBag,
        networkService: RefreshService )) {
        
        //上拉结果序列
        let footerRefreshData = footerRefresh
            .startWith(()) //初始化完毕时会自动加载一次数据
            .flatMapLatest{ return dependency.networkService.getRandomResult() }
        
        //生成停止上拉加载刷新状态序列
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        
        //上拉加载时，将查询到的结果拼接到原数据底部
        footerRefreshData.drive(onNext: { items in
            self.tableData.value = self.tableData.value + items
        }).disposed(by: dependency.disposeBag)
    }
    
}
