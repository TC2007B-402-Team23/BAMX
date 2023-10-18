//
//  HomeView.swift
//  nomeinteresa
//
//  Created by user246289 on 10/11/23.
//
import SwiftUI

struct HomeView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.8666, green: 0.5215, blue: 0.0392, alpha: 1))
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(.white)
                    .frame(width: 300)
                    .offset(y: -257)
                
                VStack {
                    Imagen()
                        .frame(height: 170)
                    Text("Bienvenido \(authenticationViewModel.user?.email ?? "No user")")
                    Cards()
                }
                .padding(.bottom, 20)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Home")
                .toolbar {
                    Button( "Logout"){
                        authenticationViewModel.logout()
                    }
                }
            }
        }
    }
}

struct Cards: View{
    var body: some View{
        VStack(alignment: .leading){
            Text("Centros de recoleccion")
                .font(.system(size: 30, weight: .bold, design: .serif))
                .foregroundColor(Color(#colorLiteral(red: 0.207, green: 0.18, blue: 0.38,alpha: 1)))
            
            ScrollView(.horizontal){
                HStack(spacing: 40){
                    VStack{
                        Image("BasilicaZ")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        VStack(alignment: .leading){
                            NavigationLink(destination: CalendarView(selectedCenter: "BasilicaZ").navigationBarBackButtonHidden(true)) {
                                Text("Basilica de Zapopan")
                                    .font(.system(size: 25, weight: .bold, design: .serif))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                                    .padding(.horizontal, 10)
                                    .offset(y: -20)
                            }
                        }
                        .frame(height: 100)
                    }
                    .frame(width: 280, height: 340)
                    .background(Color.white)
                    .cornerRadius(30)
                    
                    VStack{
                        Image("Colomos")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        VStack(alignment: .leading){
                            NavigationLink(destination: CalendarView(selectedCenter: "Colomos").navigationBarBackButtonHidden(true)){
                                Text("Parque Colomos")
                                    .font(.system(size: 25, weight: .bold, design: .serif))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                                    .padding(.horizontal, 10)
                                    .offset(y: -20)
                            }
                        }
                        .frame(height: 100)
                    }
                    .frame(width: 280, height: 340)
                    .background(Color.white)
                    .cornerRadius(30)
                    
                    VStack{
                        Image("Tlaque")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        VStack(alignment: .leading){
                            NavigationLink(destination: CalendarView(selectedCenter: "Tlaque").navigationBarBackButtonHidden(true)){
                                Text("Tlaquepaque")
                                    .font(.system(size: 25, weight: .bold, design: .serif))
                                    .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                                    .padding(.horizontal, 10)
                                    .offset(y: 0)
                            }
                        }
                        .frame(height: 100)
                    }
                    .frame(width: 280, height: 340)
                    .background(Color.white)
                    .cornerRadius(30)
                    .frame(width: 280, height: 340)
                    .background(Color.white)
                    .cornerRadius(30)
                }
            }
            .padding(.top, 12)
        }
        .padding(.leading, 30)
        .padding(.top, 60)
    }
}

struct HomeView_Previews:PreviewProvider{
    static var previews: some View{
        HomeView(authenticationViewModel: AuthenticationViewModel())
    }
}
