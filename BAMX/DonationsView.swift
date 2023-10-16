//
//  DonationsView.swift
//  BAMX
//
//  Created by Emma Gabriela Alfaro on 15/10/23.
//
import SwiftUI

struct DonationsView: View {
    @State private var quantity1 = 1.0
    @State private var quantity2 = 1.0
    @State private var quantity3 = 1.0
    @State private var quantity4 = 1.0
    @State private var quantity5 = 1.0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    Text("Donación de Alimentos")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    FoodList(foodName: "Arroz", quantity: $quantity1)
                    FoodList(foodName: "Frijoles", quantity: $quantity2)
                    FoodList(foodName: "Lentejas", quantity: $quantity3)
                    FoodList(foodName: "Enlatados", quantity: $quantity4)
                    FoodList(foodName: "Aceite", quantity: $quantity5)
                    
                }
                .padding()
                
                Divider()
                NavigationLink(destination: HoursView().navigationBarBackButtonHidden(true)) {
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
                 
                 NavigationLink(destination: SummaryView(quantity1: $quantity1, quantity2: $quantity2, quantity3: $quantity3, quantity4: $quantity4, quantity5: $quantity5)) {
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
        }
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
                
                Slider(value: $quantity, in: 1...10, step: 1)
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
        }
    }
    
    struct DonationsView_Previews: PreviewProvider {
        static var previews: some View {
            DonationsView()
        }
    }

