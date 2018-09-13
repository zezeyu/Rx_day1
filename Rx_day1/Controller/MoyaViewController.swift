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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //获取选中项信息
        let channelName = channels[indexPath.row]["name"].stringValue
        let channelId = channels[indexPath.row]["channel_id"].stringValue
        //使用我们的provider进行网络请求（根据频道ID获取下面的歌曲）
        /*
        DouBanProvider.request(.playlist(channelId)) { (result) in
            switch result {
            case let .success(response):
//                let statusCode = response.statusCode // 响应状态
                do {
                    //过滤成功的状态码响应
                    try response.filterSuccessfulStatusCodes()
                    //解析数据，获取歌曲信息
                    let data = try? response.mapJSON()
                    let json = JSON(data!)
                    print(json)
                    let array = json["song"].arrayValue
                    if array.count > 0{
                        let music = json["song"].arrayValue[0]
                        let artist = music["artist"].stringValue
                        let title = music["title"].stringValue
                        let message = "歌手：\(artist)\n歌曲：\(title)"
                        //将歌曲信息弹出显示
                        self.showAlert(title: channelName, message: message)
                    }
                    
                    
                }
                catch {
                    //处理错误状态码的响应
                }
                
            case let .failure(error):
                switch error {
                case .imageMapping(let response):
                    print("错误原因：\(error.errorDescription ?? "")")
                    print(response)
                case .jsonMapping(let response):
                    print("错误原因：\(error.errorDescription ?? "")")
                    print(response)
                case .statusCode(let response):
                    print("错误原因：\(error.errorDescription ?? "")")
                    print(response)
                case .stringMapping(let response):
                    print("错误原因：\(error.errorDescription ?? "")")
                    print(response)
                case .underlying(let error, let response):
//                    print("错误原因：\(error.errorDescription ?? "")")
                    print(error)
                    print(response as Any)
                case .requestMapping:
                    print("错误原因：\(error.errorDescription ?? "")")
                    print("nil")
                case .objectMapping(_, _): break
                case .encodableMapping(_): break
                case .parameterEncoding(_): break
                    
                }
            }

        }
      */
        Network.request(.playlist(channelId), success: { (json) in
            //获取歌曲信息
            let music = json["song"].arrayValue[0]
            let artist = music["artist"].stringValue
            let title = music["title"].stringValue
            let message = "歌手：\(artist)\n歌曲：\(title)"
            //将歌曲信息弹出显出
            self.showAlert(title: channelName, message: message)
    
        }, error: { (statusCode) in
            print("请求错误！错误码：\(statusCode)")
        }, failure: { error in
            print("请求失败！错误信息：\(error.errorDescription ?? "")")
        })
        
    }
    //显示消息
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
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
// MARK: 文件上传
extension MoyaViewController{
    func upload_data() {
        //需要上传的文件
        let fileURL = Bundle.main.url(forResource: "", withExtension: "")!
        //通过Moya提交数据
        MyServiceProvider.request(.upload(fileURL: fileURL)) { (result) in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapString()
                print(data ?? "")
            }
        }
    }
}


















