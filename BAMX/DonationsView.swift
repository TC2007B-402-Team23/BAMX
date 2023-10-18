//
//  DonationsView.swift
//  BAMX
//
//  Created by Emma Gabriela Alfaro on 15/10/23.
//
import SwiftUI

struct DonationsView: View {
    @State private var quantity1 = 0.0
    @State private var quantity2 = 0.0
    @State private var quantity3 = 0.0
    @State private var quantity4 = 0.0
    @State private var quantity5 = 0.0

    let selectedCenter: String
    let selectedDate: Date
    let selectedHour: String
    @State private var selectedDonation: [String: Double] = [:]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Donación de Alimentos")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 50)

                    FoodList(foodName: "Arroz", quantity: $quantity1)
                        .onChange(of: quantity1) { newValue in
                            selectedDonation["Arroz"] = newValue
                        }
                    FoodList(foodName: "Frijoles", quantity: $quantity2)
                        .onChange(of: quantity2) { newValue in
                            selectedDonation["Frijoles"] = newValue
                        }
                    FoodList(foodName: "Lentejas", quantity: $quantity3)
                        .onChange(of: quantity3) { newValue in
                            selectedDonation["Lentejas"] = newValue
                        }
                    FoodList(foodName: "Enlatados", quantity: $quantity4)
                        .onChange(of: quantity4) { newValue in
                            selectedDonation["Enlatados"] = newValue
                        }
                    FoodList(foodName: "Aceite", quantity: $quantity5)
                        .onChange(of: quantity5) { newValue in
                            selectedDonation["Aceite"] = newValue
                        }
                }
                .padding()

                Divider()
                NavigationLink(destination: HoursView(selectedCenter: selectedCenter, selectedDate: selectedDate).navigationBarBackButtonHidden(true)) {
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
                .offset(y: -1145)
                .offset(x: -120)

                NavigationLink(destination: SummaryView(selectedCenter: selectedCenter, selectedDate: selectedDate, selectedHour: selectedHour, selectedDonation: selectedDonation)) {
                    Text("Donar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.vertical, 20)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
        }
        .navigationBarBackButtonHidden(true)
    }

    struct FoodList: View {
        var foodName: String
        @Binding var quantity: Double

        var body: some View {
            VStack(alignment: .leading) {
                Text(" \(foodName)")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.bottom, 5)

                Slider(value: $quantity, in: 0...10, step: 1)
                    .accentColor(.blue)
                    .padding(.bottom, 20)

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

    struct DonationsView_Previews: PreviewProvider {
        static var previews: some View {
            DonationsView(selectedCenter: "NA", selectedDate: Date(), selectedHour: "")
        }
    }
}
