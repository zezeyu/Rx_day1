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
import SwiftyJSON

class MoyaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .white
        $0.tableFooterView = UIView()
    }
    
    //频道列表数据
    var channels:Array<JSON> = []
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        
        //使用我们的provider进行网络请求（获取频道列表数据）
        DouBanProvider.request(.channels){ result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                self.channels = json["channels"].arrayValue
                
                //刷新表格数据
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            }
        }

        
    }
    
    //返回表格分区数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "SwiftCell"
            let cell = tableView.dequeueReusableCell(
                withIdentifier: identify, for: indexPath)
            cell.accessoryType = .disclosureIndicator
            //设置单元格内容
            cell.textLabel?.text = channels[indexPath.row]["name"].stringValue
            return cell
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

