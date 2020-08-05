//
//  SYAppDelegate+Realm.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/3.
//  Copyright © 2020 Mandora. All rights reserved.
//

import RealmSwift

extension SYAppDelegate {
    
    func setupRealm() {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/\(Configs.dbName).realm")
        let config = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: Configs.dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        Realm.Configuration.defaultConfiguration = config
        do {
            _ = try Realm.init(configuration: config)
            print("数据库创建成功")
        } catch let error {
            print("打开或者创建数据库失败:\n\(error.localizedDescription)")
        }
    }
    
}
