//
//  DetailView.swift
//  IBI Assignment
//
//  Created by Smit Patel on 2022-11-05.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var isDismiss: Bool
    var desciprion: String
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            Text(desciprion)
                .font(.title)
                .padding()
            HStack{
                Spacer()
                Button("Home page") {
                    showingAlert = true
                }.bold()
                    .frame(width: 240, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Spacer()
            }
            Spacer()
        }.background(Color.white)
            .alert(isPresented:$showingAlert){
                Alert(title: Text("Attention"), message: Text("Do you want to go back"), primaryButton: .default(Text("Yes"), action: {
                    isDismiss = false
                }), secondaryButton: .destructive(Text("No")))
            }
    }
}

