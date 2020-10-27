//
//  Home.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 27.10.2020.
//

import SwiftUI

struct CategoryHome: View {
    @State var showingProfile = false
    
    var profileButton: some View {
        Button(action: { self.showingProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    var body: some View {
        let mainCategory: [String] = ["Кухня","Ванная", "Гардеробная", "Кабинет"]
        NavigationView {
            List {
                Image("battery")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                ForEach(mainCategory, id: \.self) { key in
                    CategoryRow(categoryName: key)
                }
                .listRowInsets(EdgeInsets())
                
                NavigationLink( destination: GarbageList()) {
                    Text("Посмотреть все")
                }
    
            }
            .navigationBarTitle(Text("Интересное"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
            }
        }
        .padding(.horizontal, -10)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
