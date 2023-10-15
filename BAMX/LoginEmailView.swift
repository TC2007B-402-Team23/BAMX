

import SwiftUI

struct LoginEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    var body: some View {
        ZStack{
            
            Color(#colorLiteral(red: 0.8666, green: 0.5215, blue: 0.0392, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(.white)
                .padding(.top, 70)
            
            VStack {
                DismissView()
                    .padding(.top, 8)
                Group {
                    Text("👋 Bienvenido a")
                    Text("Banco de alimentos")
                        .bold()
                        .underline()
                    Text("Loguéate de nuevo para poder acceder a todos tus donativos.")
                        .tint(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                        .padding(.bottom, 1)
                        .font(.system(size: 20))
                }
                .padding(.horizontal, 8)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .tint(.primary)
                
                Imagen()
                
                Group {
                    TextField("Email", text: $textFieldEmail)
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                        .background(Color(red: 0.6941, green: 0.6352, blue: 0.4784))
                        .frame(width: 200)
                        .padding(.leading, 20)
                    TextField("Contraseña", text: $textFieldPassword)
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                        .background(Color(red: 0.6941, green: 0.6352, blue: 0.4784))
                        .frame(width: 200)
                        .padding(.leading, 20)
                        .padding(.bottom, 15)
                    Button("Ingresar") {
                        authenticationViewModel.login(email: textFieldEmail, password: textFieldPassword)
                    }
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.red)
                    .cornerRadius(17)
                    if let messageError = authenticationViewModel.messageError {
                        Text (messageError)
                            .bold()
                            .font(.body)
                            .foregroundColor(.red)
                            .padding(.top, 20)
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 64)
                Spacer()
            }
        }
    }
}

struct LoginEmailView_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmailView(authenticationViewModel: AuthenticationViewModel())
    }
}
