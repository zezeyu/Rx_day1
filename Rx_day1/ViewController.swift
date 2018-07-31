//
//  ViewController.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/7/31.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //tableView对象
    @IBOutlet weak var tableView: UITableView!
    
    let dataArray:[String] = ["输入验证"]
    
    
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        //将数据源数据绑定到tableView上
//        musicListViewModel.data
//            .bind(to: tableView.rx.items(cellIdentifier:"musicCell")) { _, music, cell in
//                cell.textLabel?.text = music.name
//                cell.detailTextLabel?.text = music.singer
//            }.disposed(by: disposeBag)
//
//        //tableView点击响应
//        tableView.rx.modelSelected(Music.self).subscribe(onNext: { music in
//            print("你选中的歌曲信息【\(music)】")
//        }).disposed(by: disposeBag)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        
    }
    //点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let simple = SimpleValidationViewController()
        simple.title = dataArray[indexPath.row]
        self.navigationController?.pushViewController(simple, animated: true)
    }
    let CELL_ID = "cellID"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

