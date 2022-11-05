//
//  CustomMapView.swift
//  IBI Assignment
//
//  Created by Smit Patel on 2022-11-05.
//

import SwiftUI
import MapKit

struct CustomMapView: View {
    
    @State private var region = MKCoordinateRegion(
        // Apple Park
        center: CLLocationCoordinate2D(latitude: 37.334803, longitude: -122.008965),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      )

      @State private var lineCoordinates = [
        CLLocationCoordinate2D(latitude: 37.330828, longitude: -122.007495),
        CLLocationCoordinate2D(latitude: 37.336083, longitude: -122.007356),
        CLLocationCoordinate2D(latitude: 37.336901, longitude:  -122.012345)
      ];
    
    var body: some View {
        MapView(
              region: region,
              lineCoordinates: lineCoordinates
            )
              .edgesIgnoringSafeArea(.all)
    }
}

struct CustomMapView_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapView()
    }
}

struct MapView: UIViewRepresentable {

  let region: MKCoordinateRegion
  let lineCoordinates: [CLLocationCoordinate2D]

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    mapView.region = region

    let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
    mapView.addOverlay(polyline)

    return mapView
  }

  func updateUIView(_ view: MKMapView, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

}

class Coordinator: NSObject, MKMapViewDelegate {
  var parent: MapView

  init(_ parent: MapView) {
    self.parent = parent
  }

  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    if let routePolyline = overlay as? MKPolyline {
      let renderer = MKPolylineRenderer(polyline: routePolyline)
      renderer.strokeColor = UIColor.systemBlue
      renderer.lineWidth = 10
      return renderer
    }
    return MKOverlayRenderer()
  }
}
