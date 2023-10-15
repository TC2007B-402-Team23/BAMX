//
//  ContentView.swift
//  Banco
//
//  Created by user246289 on 10/10/23.
//

import SwiftUI

enum AuthenticationSheetView: String, Identifiable{
    case register
    case login
    
    var id: String{
        return rawValue
    }
}

struct AuthenticationView: View{
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var authenticationSheetView: AuthenticationSheetView?
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.8666, green: 0.5215, blue: 0.0392, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(.white)
            
            VStack {
                Group {
                    Text("👋 Bienvenido a")
                        .padding(.top, 50)
                        .font(.system(size: 30))
                    Text("Banco de alimentos")
                        .bold()
                        .underline()
                        .tint(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                        .padding(.bottom, 50)
                        .font(.system(size: 30))
                }
                
                Imagen()
                Button {
                    authenticationSheetView = .login
                } label: {
                    Label("Entra con Email", systemImage: "envelope.fill")
                }
                .tint (.black)
            
            .controlSize(.large)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top, 10)
            Spacer()
            
            HStack {
                Button{
                    authenticationSheetView = .register
                } label: {
                    Text("¿No tienes cuenta?")
                    Text("Regístrate")
                        .underline()
                }
                .tint(.black)
                .padding(.bottom, 80)
            }
        }
        .sheet(item: $authenticationSheetView){ sheet in
            switch sheet {
            case .register:
                RegisterEmailView(authenticationViewModel: authenticationViewModel)
            case .login:
                LoginEmailView(authenticationViewModel: authenticationViewModel)
            }
          }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        AuthenticationView(authenticationViewModel: AuthenticationViewModel())
    }
 }

