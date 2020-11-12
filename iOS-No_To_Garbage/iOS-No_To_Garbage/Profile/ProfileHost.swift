//
//  ProfileHost.swift
//  iOS-No_To_Garbage
//
//  Created by Admin on 27.10.2020.
//

import SwiftUI
import FirebaseAuth
struct ProfileHost: View {
    @State var name = "Загрузка"
    @State var garbage = ""
    let database = GetProfileInfo()
    var body: some View {
        let category:[String] = ["Батарейки", "Бумага", "Техника", "Бутылки", "Бутылки ", "Одежда в плохом состоянии", "Одежда в хорошем состоянии", "Стеклянные банки", "Контейнеры", "Коробки"]
        let user = currUser()
        if (user != nil){
            
            Text(name).onAppear(){
                database.getinfo(uid: user!.uid) { result in
                    let email = user?.email
                    name = "Добрый день, \(result).\nВаша почта: \(email ?? "")"
                }
            }
            
            
            Text(garbage).onAppear(){
                database.getGarbage(uid: user!.uid) { result in
                    garbage = result
                }
            }
            
        
            Button("Выйти") {
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
            }.padding(.top, 30)
            
        }
        
        
        
        else{
            Text("Вы еще не вошли")
            NavigationView{
                
                NavigationLink(
                    destination: SignIn(),
                    label: {
                        Text("Войти")
                    })
            }
        }
        
    }
    
    
    func currUser() -> User? {
        let user = Auth.auth().currentUser
        return user
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
