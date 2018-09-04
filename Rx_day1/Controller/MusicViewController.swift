//
//  MusicViewController.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/8/28.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Then
import SnapKit
class MusicViewController: UIViewController {

    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    lazy var tableView:UITableView = UITableView(frame: .zero, style: .plain).then { (make) in
        make.backgroundColor = UIColor.white
        make.rowHeight = 66.0
        make.tableFooterView = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        
//        musicListViewModel.data
//            .bind(to: tableView.rx.items(cellIdentifier:"musicCell")) { _, music, cell in
//                cell.textLabel?.text = music.name
//                cell.detailTextLabel?.text = music.singer
//            }.disposed(by: disposeBag)
//
//        tableView.rx.modelSelected(Music.self).subscribe(onNext: { (music) in
//            print("你选择中的歌曲信息【\(music)】")
//        }).disposed(by: disposeBag)

        // 1 初始化数据源
//        let items = Observable.just((arrModel).map {"\($0)" })
        // 2 绑定数据源到tableView
//        musicListViewModel.data.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){ (row, element, cell) in
//                  cell.textLabel?.text = element.name
//                  cell.detailTextLabel?.text = element.singer
//            }
//            .disposed(by: disposeBag)
        
        musicListViewModel.data
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                var cell = tableView.dequeueReusableCell(withIdentifier: "CELL_ID")
                if cell == nil{
                    cell = UITableViewCell.init(style: .default, reuseIdentifier: "CELL_ID")
                }
                cell?.textLabel?.text = element.singer
                cell?.detailTextLabel?.text = element.name
                cell?.imageView?.image = UIImage.init(named: "App_image")
                return cell!
            }
            .disposed(by: disposeBag)
        // 3 设置点击事件
//        tableView.rx.itemSelected.asObservable()
//            .subscribe(onNext: { index in
//                self.tableView.deselectRow(at: index, animated: true)
//            }).disposed(by: disposeBag)
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { music in
            print("你选中的歌曲【\(music)】")
        }).disposed(by: disposeBag)

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
