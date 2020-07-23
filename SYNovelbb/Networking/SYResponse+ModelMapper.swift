//
//  SYResponse+ModelMapper.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import Moya
import HandyJSON

enum SYMapperError: Swift.Error {
    case ok(message: String?)
    case json(message: String?)
    case server(message: String?)
}

extension SYMapperError {
    
    public var message: String {
        switch self {
        case .ok(let text):
            return (text ?? "操作成功!")
        case .json(let text):
            return (text ?? "解析失败！")
        case .server(let text):
            return text ?? "错误：52000"
        }
    }
}

extension Response {
    
    internal func map<T: HandyJSON>(result type: T.Type) throws -> SYResponseModel<T> {
        
        guard let jsonDictionary = try mapJSON() as? NSDictionary else {
            throw SYMapperError.json(message: "json解析失败")
        }
        
        guard let serverModel = JSONDeserializer<SYResponseModel<T>>.deserializeFrom(dict: jsonDictionary) else {
            throw SYMapperError.json(message: "json解析失败")
        }
        
        if serverModel.success == true {
            return serverModel
        } else {
            if dealEmptyResult(serverModel.message) == true {
                return serverModel
            }
            throw SYMapperError.server(message: serverModel.message.content)
        }
    }
    
    // 处理查询结果为空
    private func dealEmptyResult(_ message: MessageModel) ->Bool {
        return message.content == "查询结果为空"
    }
    
}
