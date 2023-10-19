//
//  TableView.swift
//  BAMX
//
//  Created by Emma Gabriela Alfaro on 19/10/23.
//

import SwiftUI

struct TableView: View {
    @State private var items: [InventoryItem] = []
    @State private var isLoading = false
    let selectedCenterID: String

    var body: some View {
        Text("Selected Center: \(selectedCenterID)")
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.8666, green: 0.5215, blue: 0.0392, alpha: 1))
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(.white)
                    .padding(-80)
                
    
                    VStack {
                            if isLoading {
                                ProgressView("Cargando...")
                            } else {
                                List(items) { item in
                                    Text(item.product)
                                    Text("\(item.kilos)")
                                }
                            }
                        }
                  
            }
                
                NavigationLink(destination: InventoryView(authenticationViewModel: AuthenticationViewModel()).navigationBarBackButtonHidden(true)) {
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
        .navigationBarBackButtonHidden(true)
        .onAppear(
            perform: fetchData
        )
    }
    func fetchData() {

        guard let url = URL(string: "http://34.136.18.70/warehouse?id_recollection_center=\(selectedCenterID)") else {
            print("Error: URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        isLoading = true

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }

            if let data = data {
                do {
                    let items = try JSONDecoder().decode([InventoryItem].self, from: data)
                    DispatchQueue.main.async {
                        self.items = items
                    }
                } catch {
                    print("Error al decodificar JSON: \(error)")
                }
            } else if let error = error {
                print("Error al realizar la solicitud GET: \(error)")
            }
        }.resume()
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(selectedCenterID: "NA")
    }
}
