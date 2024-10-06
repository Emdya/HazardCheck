import SwiftUI

struct RegistrationView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var registrationError: String? = nil
    @State private var isRegistered: Bool = false // Track if registration is successful

    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if let error = registrationError {
                    Text(error).foregroundColor(.red)
                }
                
                Button("Register") {
                    register()
                }
                .padding()
                
                // NavigationLink to MapView
                NavigationLink(destination: MapView(), isActive: $isRegistered) {
                    EmptyView() // Hidden link
                }
            }
            .navigationTitle("Register")
        }
    }
    
    func register() {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty, password == confirmPassword else {
            registrationError = "Please fill in all fields correctly."
            return
        }

        let newUser = User(username: username, email: email, password: password)
        
        if let userData = try? JSONEncoder().encode(newUser) {
            UserDefaults.standard.set(userData, forKey: username)
            registrationError = nil
            isRegistered = true // Set to true to navigate to MapView
        } else {
            registrationError = "Failed to save user."
        }
    }
}




