//
//  MapLogView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/25.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapLogView: View {
    @State var manager = CLLocationManager()
    @State var alert = false

    var body: some View {
        ZStack(alignment: .bottom) {
            mapView(manager: $manager, alert: $alert).alert(isPresented: $alert) {

                Alert(title: Text("Please Enable Location Access In Setting Panel!!!"))
            }
            NavigationStack {
                NavigationLink {
                    ResultView()
                } label: {
                    StartButtonView()
                }
            }
        }
        .interactiveDismissDisabled()
        .navigationBarBackButtonHidden(true)
    }
}

struct mapView : UIViewRepresentable {
    typealias UIViewType = MKMapView

    @Binding var manager : CLLocationManager
    @Binding var alert : Bool

    let map = MKMapView()

    func makeCoordinator() -> mapView.Coordinator {

        return mapView.Coordinator(parent1: self)
    }

    func  makeUIView(context: UIViewRepresentableContext<mapView>) -> MKMapView {
        // Tokyo 35.6804° N, 139.7690° E
        let center = CLLocationCoordinate2D(latitude: 35.6804, longitude: 139.7690)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 50000, longitudinalMeters: 50000)
        map.region = region

        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        map.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        return map
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {

    }

    class Coordinator: NSObject, CLLocationManagerDelegate {

        var parent : mapView

        init(parent1 : mapView) {

            parent = parent1
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

            if status == .denied{

                parent.alert.toggle()
                print("denied")
            }
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

            let location = locations.last

            let point = MKPointAnnotation()

            let georeader = CLGeocoder()
            georeader.reverseGeocodeLocation(location!) { (places, err) in

                if err != nil {

                    print((err?.localizedDescription)!)
                    return
                }

                let place = places?.first?.locality
                point.title = place
                point.subtitle = "Current Place"
                point.coordinate = location!.coordinate
                self.parent.map.removeAnnotations(self.parent.map.annotations)
//                self.parent.map.addAnnotation(point)

                let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                print(region)
                self.parent.map.region = region

            }
        }
    }
}




struct MapLogView_Previews: PreviewProvider {
    static var previews: some View {
        MapLogView()
    }
}
