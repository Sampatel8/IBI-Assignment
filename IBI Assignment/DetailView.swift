//
//  DetailView.swift
//  IBI Assignment
//
//  Created by Smit Patel on 2022-11-05.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("Desciprion")
                .font(.title)
                .padding()
            
            Text("You want go to home page")
            HStack{
                Spacer()
                Button {
                    // No Action Defined.
                } label: {
                    Text("Yes")
                        .bold()
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .padding()
                }
                Button {
                    // No action defined.
                } label: {
                    Text("No")
                        .bold()
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .padding()
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
