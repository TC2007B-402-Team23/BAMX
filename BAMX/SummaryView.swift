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
    @State private var json: [String: Any] = ["NA": 0]
    @State private var productsToJSON: String = "JSON"
    
    @State private var isDonationConfirmed = false
    @State private var showRanking = false
    
    var body: some View {
        
        /*Text("\(selectedCenterID)")
        Text("\(selectedDate)")
        Text("\(selectedHour)")
        Text("\(selectedDonation.map { "\($0.key): \($0.value) KG" }.joined(separator: ", "))")
        */
        
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
                    sendDonation()
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let deliveryDateTime = dateFormatter.string(from: selectedDate)

            let products = selectedDonation.map { key, value in
                return ["product": key, "kilos": value] as [String : Any]
            }
            
            let jsonObject: [String: Any] = [
                "id_recollection_center": selectedCenterID,
                "id_user": 3,
                "delivery_daytime": deliveryDateTime,
                "products": products
            ]

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("JSON = \(jsonString)")
                    json = jsonObject
                }
            } catch {
                print("Error al convertir a JSON: \(error)")
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
            SummaryView(selectedCenterID: "NA", selectedDate: Date(), selectedHour: "", selectedDonation: ["NA" : 0.0])
        }
    }
    
    func sendDonation() {
        guard let url = URL(string: "http://34.136.18.70/donations") else {
                print("URL inválida")
                return
            }

        var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            /*let jsonObjects = selectedDonation.map { key, value in
                return ["\(key)": value]
            }*/
        
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json)
                request.httpBody = jsonData
            } catch {
                print("Error al convertir selectedDonation a JSON: \(error)")
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Respuesta del servidor: \(responseString)")
                    }
                } else if let error = error {
                    print("Error al realizar la solicitud POST: \(error)")
                }
            }.resume()
      }
}
    
