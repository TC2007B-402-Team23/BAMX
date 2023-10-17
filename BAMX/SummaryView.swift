//
//  SummaryView.swift
//  BAMX
//
//  Created by Emma Gabriela Alfaro on 15/10/23.
//
import SwiftUI

struct SummaryView: View {
    @Binding var quantity1: Double
    @Binding var quantity2: Double
    @Binding var quantity3: Double
    @Binding var quantity4: Double
    @Binding var quantity5: Double
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
                    .padding(.top, 20)
                    .foregroundColor(.white)
                
                DonationSummary(foodName: "Arroz", quantity: quantity1)
                DonationSummary(foodName: "Frijoles", quantity: quantity2)
                DonationSummary(foodName: "Lentejas", quantity: quantity3)
                DonationSummary(foodName: "Enlatados", quantity: quantity4)
                DonationSummary(foodName: "Aceite", quantity: quantity5)
                
                Spacer()
                NavigationLink(destination: DonationsView().navigationBarBackButtonHidden(true)) {
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
                    isDonationConfirmed = true}) {
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
                                })
                             }
                             .sheet(isPresented: $showRanking) {
                                UsersRankingView()
                             }
                         }
                        .padding()
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
        SummaryView(quantity1: .constant(1.0), quantity2: .constant(1.0), quantity3: .constant(1.0), quantity4: .constant(1.0), quantity5: .constant(1.0))
    }
}

