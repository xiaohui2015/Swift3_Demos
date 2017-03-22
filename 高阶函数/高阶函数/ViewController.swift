//
//  ViewController.swift
//  高阶函数
//
//  Created by xiaohui on 2017/3/22.
//  Copyright © 2017年 xiaohui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(NSHomeDirectory())
        
        // 计算出本项目在沙盒中test文件夹下.png格式文件的大小
        
        // 在代码中使用filter方法后直接调用了map方法，这是因为高阶函数支持链式调用，高阶函数的特性就是可以以一个函数或多个函数当参数，返回值也可以是一个函数
        
        
//        // 简单粗暴的获取文件夹的路径
//        let folderPath = "/Users/xiaohui/Desktop/高阶函数/高阶函数/pictures"
        
        
        let folderPath = getFolderPath(folderName: "pictures")
        let childFiles = FileManager.default.subpaths(atPath: folderPath)! as [String]
        
        let resultSize = childFiles.filter {
            $0.components(separatedBy: ".").last == "png"
            }.map({ (fileName) -> UInt64 in
                let filePath = folderPath + "/" + fileName
                return calculateSingleFileSize(path: filePath)
            }).reduce(0) {
                $0 + $1
        }
        
        print(resultSize)
    }
    
    // 获取沙盒中Documents中某个文件夹的路径
    func getFolderPath(folderName: String) -> String {
        let folderPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        return  folderPath.appendingPathComponent(folderName)
    }
    
    // 计算单个文件的大小
    func calculateSingleFileSize(path: String) -> UInt64 {
        let fileManager = FileManager.default
        let dic = try! fileManager.attributesOfItem(atPath: path) as NSDictionary
        let size = dic.fileSize()
        return size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

