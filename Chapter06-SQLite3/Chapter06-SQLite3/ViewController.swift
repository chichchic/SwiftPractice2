//
//  ViewController.swift
//  Chapter06-SQLite3
//
//  Created by 박시현 on 2020/01/05.
//  Copyright © 2020 박시현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dbPath = self.getDBPath()
        self.dbExecute(dbPath: dbPath)
    }

    func getDBPath() -> String {
        let fileMgr = FileManager()
        
        // NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString 과 동일구문
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let dbPath = try! docPathURL.appendingPathComponent("db.sqlite").path!
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
            try! fileMgr.copyItem(at: dbSource, to: dbPath)
        }
        return dpPath
    }
    
    func dbExecute(dbPath: String) {
        var db: OpaquePointer? = nil
        
        // db객체 생성 (db)
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
            print("Database Connect Fail")
            return
        }
        
        //db 연결 종료, 함수 종료 전에 실행되는 defer활용
        defer {
            print("Close Database Connection")
            sqlite3_close(db) // db객체 해제
        }
        
        var stmt: OpaquePointer? = nil
        let sql = "CREATE TABLE IF NOT EXIST sequence (num INTEGER)" // 테이블 생성
        
        // sql구문 객체생성 (stmt)
        guard sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK  else {
            print("Prepare Statement Fail")
            return
        }
            
        // 구문 db에 전달
        if sqlite3_step(stmt) == SQLITE_OK {
                print("Create Table Success!")
            }
        
        sqlite3_finalize(stmt) // stmt구문객체 삭제 (stmt 해제)
    }
}

