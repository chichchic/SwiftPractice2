//
//  MapKitViewContorller.swift
//  Chapter03-Alert
//
//  Created by 박시현 on 2020/01/01.
//  Copyright © 2020 박시현. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {
    
    override func viewDidLoad() {
        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0)) // rootview이므로 0000값
        self.view = mapkitView
        self.preferredContentSize.height = 200 //view의 높이값 설정
        
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623) //위도 경도
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005) //축적
        let region = MKCoordinateRegion(center: pos, span: span) // 영역 표시
        
        //지도에 적용
        mapkitView.region = region
        mapkitView.regionThatFits(region)
        
        //위치를 핀으로 표시
        let point = MKPointAnnotation()
        point.coordinate = pos
        mapkitView.addAnnotation(point)
    }
}
