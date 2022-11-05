//
//  CustomMapView.swift
//  IBI Assignment
//
//  Created by Smit Patel on 2022-11-05.
//

import SwiftUI
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let title: String?
    let customDescription: String?
    let coordinate: CLLocationCoordinate2D
    init(title: String?,
         customDescription: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.customDescription = customDescription
        self.coordinate = coordinate
    }
}

struct CustomMapView: View {
    
    @Binding var isDismiss: Bool
    @State var isShowDetailView: Bool = false
    @State var defaultString: String = "Default description"
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.655967377723734, longitude: -79.3863245844841),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @ObservedObject var service = APISerive.shared
    
    var body: some View {
        ZStack{
            MapView(region: region, lineCoordinates: service.polylineDataList, annotationList: service.annotaionList, isShowDetailView: $isShowDetailView, pinDescription: $defaultString)
                .edgesIgnoringSafeArea(.all)
            
            if isShowDetailView{
                DetailView(isDismiss: $isDismiss, desciprion: defaultString)
            }
        }
    }
}


struct MapView: UIViewRepresentable {
    
    let region: MKCoordinateRegion
    let lineCoordinates: [CLLocationCoordinate2D]
    let annotationList: [CustomAnnotation]
    @Binding var isShowDetailView: Bool
    @Binding var pinDescription: String
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = region
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        updateOverlays(from: uiView)
        uiView.addAnnotations(annotationList)
    }
    
    private func updateOverlays(from mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
        mapView.addOverlay(polyline)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, $isShowDetailView, $pinDescription)
    }
    
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    @Binding var isShowDetailView: Bool
    @Binding var pinDescription: String
    
    init(_ parent: MapView, _ isShowDetailView: Binding<Bool>, _ pinDescription: Binding<String>) {
        self.parent = parent
        self._isShowDetailView = isShowDetailView
        self._pinDescription = pinDescription
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 4
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        $isShowDetailView.wrappedValue.toggle()
        if let annotationView = view.annotation as? CustomAnnotation{
            if let description = annotationView.customDescription{
                pinDescription = description
            }else{
                pinDescription = "Description is not available"
            }
        }
        
    }
}
