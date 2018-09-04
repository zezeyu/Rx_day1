//
//  RxDay3ViewController.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/9/3.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class RxDay3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let observable = Observable<String>.create{observer in
            
            observer.onNext("hangge.com")
            
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        //订阅测试
        observable.subscribe{
            print($0)
        }
        
        let ob = Observable.of("A","B","C")
        ob.subscribe{ event in
            print(event)
        }
        
        let label:UILabel = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        label.textColor = UIColor.black
        self.view.addSubview(label)
        ob.subscribe{
            print($0.element ?? String.self)
        }
        ob.subscribe(onNext: { (element) in
            label.text = element
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        })
        
        self.view.backgroundColor = UIColor.white
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
