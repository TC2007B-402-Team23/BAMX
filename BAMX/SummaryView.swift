//
//  SummaryView.swift
//  BAMX
//
//  Created by Emma Gabriela Alfaro on 15/10/23.
//
import SwiftUI

struct SummaryView: View {
    let selectedCenter: String
    let selectedDate: Date
    let selectedHour: String
    let selectedDonation: [String: Double]
    
    @State private var isDonationConfirmed = false
    @State private var showRanking = false

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8666, green: 0.5215, blue: 0.0392, alpha: 1))
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Resumen de Donación")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 100)
                    .foregroundColor(.white)

                ForEach(selectedDonation.sorted(by: <), id: \.key) { item in
                    DonationSummary(foodName: item.key, quantity: item.value)
                }

                Spacer()
                NavigationLink(destination: DonationsView(selectedCenter: selectedCenter, selectedDate: selectedDate, selectedHour: selectedHour).navigationBarBackButtonHidden(true)) {
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
                .offset(y: -625)
                .offset(x: -120)

                Button(action: {
                    isDonationConfirmed = true
                }) {
                    Text("Confirmar Donación")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
                .alert(isPresented: $isDonationConfirmed) {
                    Alert(
                        title: Text("Donación Confirmada"),
                        message: Text("Gracias por tu generosidad"),
                        dismissButton: .default(Text("Aceptar")) {
                            showRanking = true
                        }
                    )
                }
                .sheet(isPresented: $showRanking) {
                    UsersRankingView()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    struct DonationSummary: View {
        var foodName: String
        var quantity: Double

        var body: some View {
            HStack {
                Text(foodName)
                    .font(.title)
                    .foregroundColor(.blue)

                Spacer()

                Text("Cantidad: \(Int(quantity)) KG")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            )
            .padding(.vertical, 10)
            .navigationBarBackButtonHidden(true)
        }
    }

    struct SummaryView_Previews: PreviewProvider {
        static var previews: some View {
            SummaryView(selectedCenter: "NA", selectedDate: Date(), selectedHour: "", selectedDonation:["Arroz": 1.5, "Frijoles": 2.0])
        }
    }
}
