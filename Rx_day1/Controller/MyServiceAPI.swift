//
//  MyServiceAPI.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/9/13.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import Foundation
import Moya

//初始化请求的provider
let MyServiceProvider = MoyaProvider<MyService>()

//请求分类
public enum MyService {
    case upload(fileURL:URL)//上传文件
}

//请求配置
extension MyService:TargetType {
    //服务器地址
    public var baseURL: URL{
        
        return URL(string: "http://www.hangge.com")!
    }
    //各个请求的具体路径
    public var path: String{
        return "/upload.php"
    }
    //请求类型
    public var method: Moya.Method{
        return .post
    }
    //请求任务事件（这里附带上参数）
    public var task: Task{
        switch self {
        case let .upload(fileURL):
            return .uploadFile(fileURL)
        }
    }
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data{
        return "{}".data(using: String.Encoding.utf8)!
    }
    //请求头
    public var headers: [String : String]?{
        return nil
    }
    
    
}

