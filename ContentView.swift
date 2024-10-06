//
//  ContentView.swift
//  HazardCheck5.0
//
//  Created by Emdya P on 10/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginError: String? = nil
    @State private var user: User? = nil
    @State private var navigateToMapView: Bool = false // State variable for navigation

    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if let error = loginError {
                    Text(error).foregroundColor(.red)
                }
                
                Button("Login") {
                    login()
                }
                .padding()
                
                NavigationLink(destination: RegistrationView(), label: {
                    Text("Register")
                })
                
                NavigationLink(destination: SafetyExplanationView(), label: {
                    Text("Learn about Safety Algorithm")
                })
                
                // Navigation link to MapView, triggered by a state change
                NavigationLink(destination: MapView(), isActive: $navigateToMapView) { EmptyView() }
            }
            .navigationTitle("Hazard Check")
        }
    }
    
    func login() {
        if username.isEmpty || password.isEmpty {
            loginError = "Please enter both fields."
            return
        }
        
        // Simulate user authentication
        if let storedUser = UserDefaults.standard.object(forKey: username) as? Data,
           let user = try? JSONDecoder().decode(User.self, from: storedUser),
           user.password == password {
            self.user = user
            navigateToMapView = true // Navigate to MapView on successful login
        } else {
            loginError = "Invalid credentials"
        }
    }
}



