import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authManager: FirebaseAuthManager
    @State private var email = ""
    @State private var password = ""
    @State private var isShowingSignUp = false
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.1), .pink.opacity(0.1)]),
                startPoint: .topLeadingPoint,
                endPoint: .bottomTrailingPoint
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("EroticLiveX")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.purple)
                
                Text(isShowingSignUp ? "Crear Cuenta" : "Iniciar Sesión")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                VStack(spacing: 12) {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: handleAuth) {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text(isShowingSignUp ? "Registrarse" : "Iniciar Sesión")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(isLoading || email.isEmpty || password.isEmpty)
                
                Button(action: { isShowingSignUp.toggle() }) {
                    Text(isShowingSignUp ? "¿Ya tienes cuenta? Inicia sesión" : "¿No tienes cuenta? Regístrate")
                        .foregroundColor(.purple)
                        .font(.caption)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func handleAuth() {
        isLoading = true
        errorMessage = nil
        
        if isShowingSignUp {
            authManager.signUp(email: email, password: password) { result in
                isLoading = false
                switch result {
                case .success:
                    break // Se actualizará cuando Firebase notifique
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        } else {
            authManager.signIn(email: email, password: password) { result in
                isLoading = false
                switch result {
                case .success:
                    break // Se actualizará cuando Firebase notifique
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    AuthView()
        .environmentObject(FirebaseAuthManager())
}
