//
//  RxMJRefreshViewController.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/12/19.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class RxMJRefreshViewController: UIViewController {
    //表格
    var tableView:UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
//        self.tableView.mj_header = MJRefreshNormalHeader()
        
//        let viewModel = ViewModel(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver())
        
//        viewModel.tableData.asDriver()
//            .drive(tableView.rx.items) { (tableView, row, element) in
//                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
//                cell.textLabel?.text = "\(row+1)、\(element)"
//                return cell
//            }
//            .disposed(by: disposeBag)
//        //下拉刷新状态结束的绑定
//        viewModel.endHeaderRefreshing
//            .drive(self.tableView.mj_header.rx.endRefreshing)
//            .disposed(by: disposeBag)
        self.tableView.mj_footer = MJRefreshBackNormalFooter()
        
        let viewModel = ViewModel(footerRefresh: self.tableView.mj_footer.rx.refreshing.asDriver(), dependency: (disposeBag: disposeBag, networkService: RefreshService()))
        viewModel.tableData.asDriver()
            .drive(tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(row+1)、\(element)"
                return cell
            }
            .disposed(by: disposeBag)
    
        viewModel.endFooterRefreshing.drive(self.tableView.mj_footer.rx.endRefreshing).disposed(by: disposeBag)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
