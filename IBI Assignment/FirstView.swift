//
//  ContentView.swift
//  IBI Assignment
//
//  Created by Smit Patel on 2022-11-05.
//

import SwiftUI

struct FirstView: View {
    
    @State var isShowCustomMapView = false
    
    var body: some View {
        ZStack {
            VStack{
                Text("Welcome")
                    .bold()
                    .font(.title)
                    .padding()
                
                Button("Map View") {
                    isShowCustomMapView.toggle()
                }.bold()
                    .frame(width: 240, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if isShowCustomMapView {
                CustomMapView(isDismiss: $isShowCustomMapView)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
