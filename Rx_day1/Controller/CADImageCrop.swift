//
//  CADImageCrop.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/9/13.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import UIKit

class CADImageCrop: NSObject {
    //1.先实现这个方法后得到返回的照片
    func scaleToSize(image:UIImage!,size:CGSize) -> UIImage {
        // 得到图片上下文，指定绘制范围
        UIGraphicsBeginImageContext(size);
        // 将图片按照指定大小绘制
        image.draw(in: CGRect(x:0,y:0,width:size.width,height:size.height))
        // 从当前图片上下文中导出图片
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        // 当前图片上下文出栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return img
    }
    //2.实现这个方法,,就拿到了截取后的照片.
    func imageFromImage(imageFromImage:UIImage!,inRext:CGRect) ->UIImage{
        //将UIImage转换成CGImageRef
        let sourceImageRef:CGImage = imageFromImage.cgImage!
        //按照给定的矩形区域进行剪裁
        //        CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
        
        let newImageRef:CGImage = sourceImageRef.cropping(to: inRext)!
        //将CGImageRef转换成UIImage
        //        UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
        let img:UIImage = UIImage.init(cgImage: newImageRef)
        
        //返回剪裁后的图片
        return img
        
    }
    
    
}
