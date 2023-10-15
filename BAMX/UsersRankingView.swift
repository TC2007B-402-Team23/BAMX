//
//  UsersRankingView.swift
//  BAMX
//
//  Created by Emma Gabriela Alfaro on 15/10/23.
//
import SwiftUI

struct UsersRankingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                   
                    Image("LOGO")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height:200)
                    
                    Text("")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    DonorRow(name: "Jared", donations: 10)
                    DonorRow(name: "Salvador" , donations: 8)
                    DonorRow(name: "Emma", donations: 7)
                    DonorRow(name: "Omar", donations: 2)
                    
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle("🌟 TOP DONANTES 🌟")
        }
    }
}

struct DonorRow: View {
    var name: String
    var donations: Int
    
    var body: some View {
        HStack {
            Text(name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading, 10)
            Spacer()
            Text("Donaciones: \(donations)")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.trailing, 10)
        }
        .padding(10)
        .background(Color.orange)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 2)
        )
        .shadow(radius: 5)
        
    }
}

struct ContentView_Previews6: PreviewProvider {
    static var previews: some View {
        UsersRankingView()
    }
}
