import SwiftUI

struct ContentView: View {
    @StateObject private var authManager = FirebaseAuthManager()
    @State private var isShowingLoginView = true
    
    var body: some View {
        ZStack {
            if authManager.isLoggedIn {
                MainTabView()
                    .environmentObject(authManager)
            } else {
                AuthView()
                    .environmentObject(authManager)
            }
        }
    }
}

struct MainTabView: View {
    @EnvironmentObject var authManager: FirebaseAuthManager
    
    var body: some View {
        TabView {
            // Tab: Home
            HomeView()
                .tabItem {
                    Label("Inicio", systemImage: "house.fill")
                }
            
            // Tab: Streams (Directos)
            StreamsView()
                .tabItem {
                    Label("Directos", systemImage: "video.fill")
                }
            
            // Tab: Marketplace
            MarketplaceView()
                .tabItem {
                    Label("Tienda", systemImage: "bag.fill")
                }
            
            // Tab: Messages
            MessagesView()
                .tabItem {
                    Label("Mensajes", systemImage: "message.fill")
                }
            
            // Tab: Profile
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
        }
        .accentColor(.purple)
    }
}

// MARK: - Vistas Placeholder

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                Text("¡Bienvenido a EroticLiveX!")
                Text("Directos en vivo")
                Text("Contenido exclusivo")
            }
            .navigationTitle("Inicio")
        }
    }
}

struct StreamsView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Directos en vivo")
            }
            .navigationTitle("Directos")
        }
    }
}

struct MarketplaceView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Marketplace")
            }
            .navigationTitle("Tienda")
        }
    }
}

struct MessagesView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Conversaciones")
            }
            .navigationTitle("Mensajes")
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject var authManager: FirebaseAuthManager
    
    var body: some View {
        NavigationView {
            VStack {
                if let currentUser = authManager.currentUser {
                    VStack(alignment: .leading) {
                        Text(currentUser.email ?? "Usuario")
                            .font(.title2)
                        Text("Email verificado")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    Button(action: { authManager.signOut() }) {
                        Text("Cerrar Sesión")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            .navigationTitle("Perfil")
        }
    }
}

#Preview {
    ContentView()
}
