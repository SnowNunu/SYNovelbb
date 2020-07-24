//
//  SYApis.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/22.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import Moya

enum SYApis {
    
    case login
    
    case homePage
}

extension SYApis: TargetType {
    
    // 配置请求url
    var baseURL: URL {
        #if DEBUG
        return URL(string: Configs.Network.dev_url)!
        #else
        return URL(string: Configs.Network.pro_url)!
        #endif
    }
    
    // 配置请求path
    var path: String {
        switch self {
        case .homePage:
            return "/1/book/index_1"
        default:
            return ""
        }
    }
    
    // 配置请求方法
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    // 单元测试返回的数据
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        guard let params = parameters else {
            return .requestPlain
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

extension SYApis {
    
    private var parameters: [String: Any]? {
//        var paramters = AppSetup.instance.requestParam
        var paramters = [String: Any]()
        switch self {
            
        case .homePage:
            paramters["system"] = 2
            return paramters
            
        default:
            return paramters
        }
    }
    
}

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<SYApis>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let SYProvider = MoyaProvider<SYApis>(requestClosure: timeoutClosure, plugins: [SYRequestLoadingPlugin(), SYMoyaPlugins.SYNetworkActivityPlugin])
