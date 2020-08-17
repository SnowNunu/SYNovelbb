//
//  SYMoyaPlugins.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/22.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import Moya

struct SYMoyaPlugins {
    
    static let SYNetworkActivityPlugin = NetworkActivityPlugin { (change, _) in
        switch(change) {
        case .ended:
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        case .began:
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
    }

}

public final class SYRequestLoadingPlugin: PluginType {
    
    public func willSend(_ request: RequestType, target: TargetType) {
        let api = target as! SYApis
        
        switch api {
//            case .touristLogin, .userInfo(_):
//                break
//            case .delAutoBuy(_),.bookself, .pro(_, _, _, _):
//                SRHelper.userIsOk()
            default:
                break
        }
        
        // 打印请求url
        #if DEBUG
        switch api.task {
            case .requestParameters(let parameters, _):
                print("request url:" + api.baseURL.absoluteString + api.path + ((parameters as NSDictionary?)?.keyValues() ?? ""))
            default:
                print("request url:" + api.baseURL.absoluteString + api.path)
        }
        #endif
        
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        switch result {
        case .success(let response):
            guard let api = target as? SYApis else {
                return
            }
            
            switch api {
//            case .chapterContent(_, _ , _):
//                do {
//
//                    let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
//                    guard let rdic = json as? [String : Any] else {
//                        return
//                    }
//
//                    guard let data = rdic["data"] as? [String : Any] else {
//                        return
//                    }
//
//                    //新加入代码
//                    if  let dict:Dictionary = try? JSONSerialization.jsonObject(with: response.data, options: []) as! [AnyHashable: Any]{
//                        let internet = ResultChapterContentModel(JSON: (dict as! [String : AnyObject]))
//                        if internet?.data?.chapter.first?.isVip ?? false {
//                            if let vipMoney = data["vipMoney"] as? Int {
//                                UserInfoModel.updateVipMoney(money: vipMoney)
//                            }
//                            if let diamonds = data["Diamonds"] as? Int {
//                                UserInfoModel.updateDiamondsMoney(money: "\(diamonds)")
//                            }
//                        }
//                    }
//                } catch  {
//                    PrintLog(error)
//                }
                
//                break
                
            default:
                break
            }
            
            break
        case .failure(let error):
            break
        }
    }
    
}

extension NSDictionary {
    
    /// 将字典转中的键值对转化到url中
    /// - Parameter params: 键值对
    /// - Returns: url 字符串
    public func keyValues() -> String {
        let string = NSMutableString.init(string: "?")
        enumerateKeysAndObjects({ (key, value, stop) in
            string.append("\(key)=\(value)&")
        })
        
        let range = string.range(of: "&", options: .backwards)
        if range.length > 0 {
            string.deleteCharacters(in: range)
        }
        return string as String
    }
    
}
