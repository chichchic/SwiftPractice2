//
//  EmployeeDAO.swift
//  Chapter06-HR
//
//  Created by 박시현 on 2020/01/05.
//  Copyright © 2020 박시현. All rights reserved.
//

enum EmpStateType: Int {
    case ING = 0, STOP, OUT
    
    func desc() -> String {
        switch self {
        case .ING:
            return "재직중"
        case .STOP:
            return "휴직"
        case .OUT:
            return "퇴사"
        }
    }
}

struct EmployeeVO {
    var empCd = 0
    var empName = ""
    var joinDate = ""
    var stateCd = EmpStateType.ING
    var departCd = 0
    var departTitle = ""
}

class EmployeeDAO {
    
    lazy var fmbd: FMDatabase! = {
        let fileMgr = FileManager.default
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        
        let db = FMDatabase(path: dbPath) // db생성
        return db
    }()
    
    init() {
        self.fmbd.open()
    }
    
    deinit {
        self.fmbd.close()
    }
    
    func find(departCd: Int = 0) -> [EmployeeVO] {
        var employeeList = [EmployeeVO]()
        
        do {
            
            let condition = departCd == 0 ? "" : "WHERE Employee.depart_cd = \(departCd)"
            
            let sql = """
                SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
                FROM employee
                JOIN department On department.depart_cd = employee.depart_cd
                \(condition)
                ORDER BY employee.depart_cd ASC
            """
            
            let rs = try self.fmbd.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = EmployeeVO()
                
                record.empCd = Int(rs.int(forColumn: "emp_cd"))
                record.empName = rs.string(forColumn: "emp_name")!
                record.joinDate = rs.string(forColumn: "join_date")!
                record.departTitle = rs.string(forColumn: "depart_title")!
                
                let cd = Int(rs.int(forColumn: "state_cd"))
                record.stateCd = EmpStateType(rawValue: cd)!
                
                employeeList.append(record)
            }
                
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return employeeList
    }
    
    func get(empCd: Int) -> EmployeeVO? {
        let sql = """
            SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
            FROM employee
            JOIN department On department.depart_cd = employee.depart_cd
            WHERE emp_cd = ?
        """
        
        let rs = self.fmbd.executeQuery(sql, withArgumentsIn: [empCd])
        
        if let _rs = rs {
            _rs.next()
            
            var record = EmployeeVO()
            record.empCd = Int(rs.int(forColumn: "emp_cd"))
            record.empName = rs.string(forColumn: "emp_name")!
            record.joinDate = rs.string(forColumn: "join_date")!
            record.departTitle = rs.string(forColumn: "depart_title")!
            
            let cd = Int(rs.int(forColumn: "state_cd"))
            record.stateCd = EmpStateType(rawValue: cd)!
            
            return record
        } else {
            return nil
        }
    }
    
    func create(param: EmployeeVO) -> Bool {
        do {
            let sql = """
                INSERT INTO employee (emp_name, join_date, state_cd, depart_cd)
                VALUES ( ? , ? , ? , ? )
            """
            var params = [Any]() // 다양한 타입을 담을 수 있는 객체
            params.append(param.empName)
            params.append(param.joinDate)
            params.append(param.stateCd.rawValue)
            params.append(param.departCd)
            
            try self.fmbd.excuteUpdate(sql, values: params)
            
            return true
        } catch let error as NSError {
            print("Insert Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(empCd: Int) -> Bool {
        do {
            let sql = "DELETE FROM employee WHERE emp_cd= ?"
            try self.fmbd.executeUpdate(sql, values: [empCd])
            return true
        } catch let error as NSError {
            print("DELETE Error: \(error.localizedDescription)")
                       return false
        }
    }
}
