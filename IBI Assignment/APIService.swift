//
//  APIService.swift
//  IBI Assignment
//
//  Created by Smit Patel on 2022-11-05.
//

import Foundation
import MapKit

struct AnnotationData : Codable{
    var markers : [Marker]
}
struct Marker: Codable {
    var lat : Double
    var lon : Double
    var name : String
    var description : String?
    var color : String
}

class APISerive : ObservableObject {
    
    public static var shared : APISerive{
        let s = APISerive()
        s.getPolylineData()
        s.getAnnotations()
        return s
    }
    
    @Published var annotaionList = [CustomAnnotation]()
    @Published var polylineDataList = [CLLocationCoordinate2D]()
    
    func getPolylineData(){
        var lineCoordinates : [CLLocationCoordinate2D] = []
        
        let urlString = "https://ibimobile-interview.s3.amazonaws.com/test_polyline.json"
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [self] data, response, error in
                //print(data)
                if error != nil{
                    print(error!.localizedDescription)
                }
                if let safeData = data{
                    do{
                        if let json = try JSONSerialization.jsonObject(with: safeData, options: []) as? [String:Any]{
                            if let polyline = json["polyline"] as? [[Double]]{
                                
                                for item in 0..<polyline.count{
                                    lineCoordinates.append(CLLocationCoordinate2D(latitude: polyline[item].first!, longitude: polyline[item].last!))
                                }
                                DispatchQueue.main.async { [self] in
                                    polylineDataList = lineCoordinates
                                }
                            }
                        }
                    }catch let error as NSError {
                        print("Failed to load : \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }
    
    func getAnnotations(){
        
        let urlString = "https://ibimobile-interview.s3.amazonaws.com/test_annotations.json"
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [self] data, response, error in
                if error != nil{
                    print(error!.localizedDescription)
                }
                if let safeData = data{
                    let decoder = JSONDecoder()
                    do {
                        let annotationData = try decoder.decode(AnnotationData.self, from: safeData)
                        var tempData = [CustomAnnotation]()
                        for annotation in annotationData.markers{
                            let item = CustomAnnotation(title: annotation.name, customDescription: annotation.description, coordinate: CLLocationCoordinate2D(latitude: annotation.lat, longitude: annotation.lon))
                            tempData.append(item)
                        }
                        DispatchQueue.main.async { [self] in
                            annotaionList = tempData
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
    }
    
    
}
