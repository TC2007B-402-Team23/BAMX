//
//  HoursView.swift
//  BAMX
//
//  Created by Emma Gabriela Alfaro on 14/10/23.
//
import SwiftUI

struct HoursView: View {
    @State private var selectedHora: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.8666, green: 0.5215, blue: 0.0392, alpha: 1))
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Miércoles")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Text("6 de octubre de 2023")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Divider()
                        .background(.white)
                        .frame(height: 2)
                        .padding(.top, 10)
                    
                    Text("Seleccione un horario")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    
                    Horas(selectedHora: $selectedHora)
                    
                    Spacer()
                    
                    NavigationLink(destination: DonationsView()) {
                        Text("Continuar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                }
                NavigationLink(destination: CalendarView().navigationBarBackButtonHidden(true)) {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Regresar")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.blue)
                }
                .offset(y: -350)
                .offset(x: -120)
            }
        }
    }
}


struct Horas: View {
    @Binding var selectedHora: String?

    var body: some View {
        VStack(spacing: 25) {
            HoraButton(text: "10:30 - 11:00", selectedHora: $selectedHora)
            HoraButton(text: "11:00 - 11:30", selectedHora: $selectedHora)
            HoraButton(text: "11:30 - 12:00", selectedHora: $selectedHora)
            HoraButton(text: "12:00 - 12:30", selectedHora: $selectedHora)
        }
    }
}

struct HoraButton: View {
    let text: String
    @Binding var selectedHora: String?

    var body: some View {
        Button(action: {
            selectedHora = text
        }) {
            Text(text.uppercased())
                .font(.headline)
                .foregroundColor(.white)
                .padding(30)
                .frame(width: 350, height: 70)
                .background(selectedHora == text ? Color.green : Color.red)
                .cornerRadius(60)
        }
    }
}

struct HoursView_Previews: PreviewProvider {
    static var previews: some View {
        HoursView()
    }
}
