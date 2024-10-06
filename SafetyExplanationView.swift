//
//  SafetyExplanationView.swift
//  HazardCheck5.0
//
//  Created by Emdya P on 10/6/24.
//


import SwiftUI

struct SafetyExplanationView: View {
    var body: some View {
        ScrollView {
            Text("Safety Algorithm Explanation")
                .font(.title)
                .padding()
            
            Text("The safety of an area is assessed based on various factors, including:")
                .padding()
            
            VStack(alignment: .leading) {
                Text("1. Crime Rate")
                Text("2. Time of Day")
                Text("3. Day of Week")
                Text("4. Recent Criminal Activity")
            }
            .padding()
            
            Text("Understanding these factors is crucial for college students to ensure their safety and well-being.")
                .padding()
            
            Text("Research shows that being aware of your surroundings can significantly reduce the likelihood of becoming a victim of crime.")
                .padding()
        }
        .navigationTitle("Safety Algorithm")
    }
}
