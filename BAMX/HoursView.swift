//
//  HoursView.swift
//  BAMX
//
//  Created by Emma Gabriela Alfaro on 14/10/23.
//
import SwiftUI

struct HoursView: View {
    @State private var selectedHour: String = ""
    let selectedCenterID: String
    let selectedDate: Date

    var body: some View {
        Text("Selected Date: \(selectedDate)")

        NavigationView {
            ZStack{
                Color(#colorLiteral(red: 0.8666, green: 0.5215, blue: 0.0392, alpha: 1))
                                .edgesIgnoringSafeArea(.all)
                            
                VStack {
                    Text("Miércoles")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 70)

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
                        .padding(.bottom, 60)
                    
                    HourSelection(selectedHour: $selectedHour)
                    
                    Spacer()
                    
                    NavigationLink(destination: DonationsView(selectedCenterID: selectedCenterID, selectedDate: selectedDate, selectedHour: selectedHour)) {
                        Text("Continuar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                            .navigationBarBackButtonHidden(true)
                    }
                }
                NavigationLink(destination: CalendarView(selectedCenterID: selectedCenterID).navigationBarBackButtonHidden(true)) {
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
        .navigationBarBackButtonHidden(true)
    }
}

struct HourSelection: View {
    @Binding var selectedHour: String

    var body: some View {
        VStack {
            HourButton(time: "10:30 - 11:00", selectedHour: $selectedHour)
            HourButton(time: "11:00 - 11:30", selectedHour: $selectedHour)
            HourButton(time: "11:30 - 12:00", selectedHour: $selectedHour)
            HourButton(time: "12:00 - 12:30", selectedHour: $selectedHour)
        }
    }
}

struct HourButton: View {
    let time: String
    @Binding var selectedHour: String

    var body: some View {
        Button(action: {
            selectedHour = time
        }) {
            Text(time.uppercased())
                .font(.headline)
                .foregroundColor(.white)
                .padding(30)
                .frame(width: 350, height: 70)
                .background(selectedHour == time ? Color.green : Color.red)
                .cornerRadius(60)
        }
    }
}

struct HoursView_Previews: PreviewProvider {
    static var previews: some View {
        HoursView(selectedCenterID: "NA", selectedDate: Date())
    }
}
