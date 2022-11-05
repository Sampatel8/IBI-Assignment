//
//  ContentView.swift
//  IBI Assignment
//
//  Created by Smit Patel on 2022-11-05.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        VStack{
            Text("Welcome")
                .bold()
                .font(.title)
                .padding()
            
            Button("Map View") {
                // Action For MapView Button
            }.bold()
                .frame(width: 240, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
