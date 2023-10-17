//
//  CalendarView.swift
//  BAMX
//
//  Created by Emma Gabriela Alfaro on 14/10/23.
//
import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.8666, green: 0.5215, blue: 0.0392, alpha: 1))
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(.white)
                    .padding(-80)
                
                VStack {
                    Spacer()
                    Horarios()
                    NavigationLink(destination: HoursView()) {
                        Text("Continuar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .navigationBarBackButtonHidden(true)
                    }
                }
                
                NavigationLink(destination: HomeView(authenticationViewModel: AuthenticationViewModel()).navigationBarBackButtonHidden(true)) {
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

struct Horarios: View {
    @State private var selectedDate = Date()
    let disabledDates: ClosedRange<Date> = {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let sevenDaysFromToday = calendar.date(byAdding: .day, value: 7, to: today)!
        return today...sevenDaysFromToday
    }()

    var body: some View {
        VStack {
            Text("Selecciona la fecha")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .offset(y: -125)

            DatePicker("Selecciona una fecha", selection: $selectedDate, displayedComponents: .date)
                .accentColor(.red)
                .offset(y: -75)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .padding(.bottom, 85)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
