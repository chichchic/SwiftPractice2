//
//  DepartmentDAO.swift
//  Chapter06-HR
//
//  Created by 박시현 on 2020/01/05.
//  Copyright © 2020 박시현. All rights reserved.
//

class DepartmentDAO {
    typealias DepartRecord = (Int, String, String)
    
    lazy var fmbd: FMDatabase! = {
        let fileMgr = FileManager.default
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    init() {
        self.fmbd.open()
    }
    
    deinit {
        self.fmbd.close()
    }
    
    func find() -> [DepartRecord] {
        var departList = [DepartRecord]()
        
        do {
            let sql = """
                SELECT depart_cd, depart_title, depart_addr
                FROM department
                ORDER BY depart_cd ASC
            """
            
            let rs = try self.fmbd.executeQuery(sql, values: nil)
            
            while rs.next() {
                let departCd = rs.int(forColumn: "depart_cd")
                let departTitle = rs.string(forColumn: "depart_title")
                let departAddr = rs.string(forColumn: "depart_addr")
                
                departList.append( (Int(departCd), departTitle!, departAddr! ) )
            }
                
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return departList
    }
    
    func get(departCd: Int) -> DepartRecord? {
        let sql = """
            SELECT depart_cd, depart_title, depart_addr
            FROM department
            WHERE depart_cd = ?
        """
        
        let rs = self.fmbd.executeQuery(sql, withArgumentsIn: [departCd])
        
        if let _rs = rs {
            _rs.next()
            
            let departId = _rs.int(forColumn: "depart_cd")
            let departTitle = _rs.string(forColumn: "depart_title")
            let departAddr = _rs.string(forColumn: "depart_addr")
            
            return (Int(departId), departTitle!, departAddr!)
        } else {
            return nil
        }
    }
    
    func create(title: String!, addr: String!) -> Bool {
        do {
            let sql = """
                INSERT INTO department (depart_title, depart_addr)
                VALUES ( ? , ? )
            """
            guard title != nil && title?.isEmpty == false else {
                return false
            }
            guard addr != nil && addr?.isEmpty == false else {
                return false
            }
            try self.fmbd.executeUpdate(sql, values: [title!, addr!])
            return true
        } catch let error as NSError {
            print("Insert Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(departCd: Int) -> Bool {
        do {
            let sql = "DELETE FROM department WHERE depart_cd= ?"
            try self.fmbd.executeUpdate(sql, values: [departCd])
            return true
        } catch let error as NSError {
            print("DELETE Error: \(error.localizedDescription)")
                       return false
        }
    }
}
