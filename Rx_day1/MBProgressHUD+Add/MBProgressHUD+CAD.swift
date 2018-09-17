//
//  MBProgressHUD+CAD.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/9/14.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD{
    class public func show(text:String,icon:String,view:UIView!) {
        var vw = view
        if vw == nil{
            vw = UIApplication.shared.keyWindow
        }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.detailsLabelText = text
        hud?.detailsLabelFont = UIFont.init(name: "Arial", size: 16)
        //设置图片
        hud?.mode = MBProgressHUDMode.customView
        //隐藏时候从父控件中移除
        hud?.removeFromSuperViewOnHide = true
        hud?.dimBackground = false
    }
    
    class public func showError(error:String,toView:UIView!){
        self.show(text: error, icon: "errors.png", view: toView)
    }
    class public func showSuccess(success:String,toView:UIView!){
        self.show(text: success, icon: "success.png", view: toView)
    }
    class public func showError(error:String){
        self.show(text: error, icon: "errors.png", view: nil)
    }
    class public func showSuccess(success:String){
        self.show(text: success, icon: "success.png", view: nil)
    }
    /**
     *  显示错误信息
     *
     *  @param message 信息内容
     *
     *  @return 直接返回一个MBProgressHUD，需要手动关闭
     */
    @discardableResult
    class public func showMessage(message:String) -> MBProgressHUD!{
        return self.showMessage(message: message, toView: nil)
    }
    /**
     *  显示一些信息
     *
     *  @param message 信息内容
     *  @param view    需要显示信息的视图
     *
     *  @return 直接返回一个MBProgressHUD，需要手动关闭
     */
    @discardableResult
    class public func showMessage(message:String,toView:UIView!) -> MBProgressHUD!{
        var vw = toView
        if vw == nil{
            vw = UIApplication.shared.keyWindow
        }
        let hud = MBProgressHUD.showAdded(to: vw, animated: true)
        hud?.detailsLabelText = message
        hud?.detailsLabelFont = UIFont.init(name: "Arial", size: 16)
        //隐藏时候从父控件中移除
        hud?.removeFromSuperViewOnHide = true
        hud?.dimBackground = false
        return hud
    }
    /**
     *  手动关闭MBProgressHUD
     */
    
    class public func hideHUD(){
        self.hideHUDForView(view: nil)
    }
    /**
     *  手动关闭MBProgressHUD
     *
     *  @param view    显示MBProgressHUD的视图
     */
    class public func hideHUDForView(view:UIView!){
        var vw = view
        if vw == nil{
            vw = UIApplication.shared.keyWindow
            self.hide(for: vw, animated: true)
        }
    }
}

















