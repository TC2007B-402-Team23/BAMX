//
//  SummaryView.swift
//  BAMX
//
//  Created by Emma Gabriela Alfaro on 15/10/23.
//
import SwiftUI

struct Donation: Encodable {
    let Aceite: Double
    let Arroz: Double
    let Enlatados: Double
    let Lentejas: Double
    let Frijoles: Double
    
    private enum CodingKeys: String, CodingKey {
        case Aceite
        case Arroz
        case Enlatados
        case Lentejas
        case Frijoles
    }
}

struct SummaryView: View {
    let selectedCenterID: String
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
                NavigationLink(destination: DonationsView(selectedCenterID: selectedCenterID, selectedDate: selectedDate, selectedHour: selectedHour).navigationBarBackButtonHidden(true)) {
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
        .onAppear {
            let jsonObjects = selectedDonation.map { key, value in
                return ["\(key)": value]
            }

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObjects, options: .prettyPrinted)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("products = \(jsonString)")
                }
            } catch {
                print("Error converting selectedDonation to JSON: \(error)")
            }
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
                SummaryView(selectedCenterID: "NA", selectedDate: Date(), selectedHour: "", selectedDonation:["Arroz": 1.5, "Frijoles": 2.0])
            }
        }
    }
    
    /*func sendDonation() {
     guard let url = URL(string: "http://34.136.18.70/donations") else {
     print("URL inválida")
     return
     }
     let products = [
     
     ]
     let json: [String: Any] = [
     "delivery_daytime": selectedDate + selectedHour,
     "id_recollection_center": selectedCenterID,
     "id_user": 2,
     "products": []
     "kilos": selectedDonation["Atun"] ?? 0.0,
     "product": "Atun"
     ]
     
     guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
     print("Error al convertir los datos a JSON")
     return
     }
     
     var request = URLRequest(url: url)
     request.httpMethod = "POST"
     request.httpBody = jsonData
     request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
     URLSession.shared.dataTask(with: request) { (data, response, error) in
     if let error = error {
     print("Error al realizar la solicitud: \(error)")
     return
     }
     
     if let data = data {
     if let responseString = String(data: data, encoding: .utf8) {
     print("Respuesta del servidor: \(responseString)")
     }
     }
     }.resume()
     }
     }*/
    
