//
//  HomeView.swift
//  nomeinteresa
//
//  Created by user246289 on 10/11/23.
//
import SwiftUI

struct HomeView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var selectedCenterID: String = "NA"

    struct RecollectionCenter: Identifiable {
        var id: String
        var name: String
        var imageName: String
    }
    
    let recollectionCenters = [
        RecollectionCenter(id: "1", name: "Basilica de Zapopan", imageName: "BasilicaZ"),
        RecollectionCenter(id: "2", name: "Parque Colomos", imageName: "Colomos"),
        RecollectionCenter(id: "3", name: "Tlaquepaque", imageName: "Tlaque")
    ]
    
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
                    Cards(recollectionCenters: recollectionCenters, selectedCenterID: $selectedCenterID) // Pasar el binding aquí
                }
                .padding(.bottom, 20)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Home")
                .toolbar {
                    Button("Logout") {
                        authenticationViewModel.logout()
                    }
                }
            }
        }
    }
}

struct Cards: View {
    let recollectionCenters: [HomeView.RecollectionCenter]
    @Binding var selectedCenterID: String 

    var body: some View {
        VStack(alignment: .leading) {
            Text("Centros de recoleccion")
                .font(.system(size: 30, weight: .bold, design: .serif))
                .foregroundColor(Color(.sRGB, red: 0.207, green: 0.18, blue: 0.38, opacity: 1))

            ScrollView(.horizontal) {
                HStack(spacing: 40) {
                    
                    ForEach(recollectionCenters) { center in
                        VStack {
                            Image(center.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 280, height: 300)
                                .cornerRadius(30)

                            VStack(alignment: .leading) {
                                NavigationLink(destination: CalendarView(selectedCenterID: center.id)
                                    .navigationBarBackButtonHidden(true)) {
                                    Text(center.name)
                                        .font(.system(size: 25, weight: .bold, design: .serif))
                                        .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 15)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .offset(y: -20)
                                }
                            }
                            .frame(height: 100)
                        }
                    }
                    
                }
            }
           .padding(.top, 12)
        }
        .padding(.leading, 30)
        .padding(.top, 60)
    }
}

struct HomeView_Previews: PreviewProvider {
     static var previews: some View {
         HomeView(authenticationViewModel: AuthenticationViewModel())
     }
 }
