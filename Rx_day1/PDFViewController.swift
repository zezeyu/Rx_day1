//
//  PDFViewController.swift
//  Rx_day1
//
//  Created by 何泽的mac on 2018/8/1.
//  Copyright © 2018年 何泽的mac. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController,UIWebViewDelegate {

    var webView:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = UIWebView()
        webView.delegate = self
        webView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        webView.backgroundColor = UIColor.white
        let filePath = URL.init(string: Bundle.main.path(forResource: "PDF", ofType: "pdf")!)
        let request = URLRequest.init(url: filePath!)
        webView.loadRequest(request)
        //是文档显示范围适合UIWebView的bounds
//        webView.scalesPageToFit = true
        
        self.view.addSubview(webView)
        
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.frame = CGRect(x: 0, y: 6600, width: UIScreen.main.bounds.size.width, height: 45)
        self.webView.scrollView.addSubview(view)
        
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        let height = webView.scrollView.contentSize.height
        print(height)
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
