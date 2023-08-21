//
//  LoginView.swift
//  wodApp
//
//  Created by 최최광현 on 2023/08/21.
//

import SwiftUI

struct LoginView: View {
    @State var id: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Text("Welcome back to our app!!")
            VStack {
                TextField("Id", text: $id)
                    .padding(.vertical, 10)
                    .padding(.leading, 10)
                TextField("password", text: $password)
                    .padding(.vertical, 10)
                    .padding(.leading, 10)
            }
            .border(Color.red.opacity(0.1), width:  1)
            .padding(.all, 24)
            HStack {
                Button(action:  {
                    if checkId() {
                        print("id 통과")
                    } else {
                        print("id 통과 x")
                    }
                }) {
                    Text("Login")
                }
                .padding(.all, 20)
                .background(Color.green)
                .cornerRadius(5)
                
                Button(action:  {
                    print("sign in")
                }) {
                    Text("Sign in")
                }
                .padding(20)
                .background(Color.green)
                .cornerRadius(5)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func checkId() -> Bool {
        if id.isEmpty {
            return false
        }
        return true
    }
    
    private func checkPassword() -> Bool {
        if password.isEmpty {
            return false
        }
        return password.count >= 12
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
