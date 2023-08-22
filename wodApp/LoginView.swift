//
//  LoginView.swift
//  wodApp
//
//  Created by 최최광현 on 2023/08/21.
//

import SwiftUI

private struct LGButton: View {
    var action: () -> Void
    
    var content: () -> Text
    
    init(action: @escaping () -> Void,
         content: @escaping () -> Text) {
        self.action = action
        self.content = content
    }
    
    var body: some View {
        content()
            .font(.body)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .onTapGesture {
                action()
            }
    }
}

struct LoginView: View {
    @State var id: String = ""
    @State var password: String = ""
    @State var showToast: Bool = false
    @State var message: String = ""
    var body: some View {
        VStack {
            Text("Welcome back to our app!!")
            VStack {
                TextField("Id", text: $id)
                    .padding(.vertical, 10)
                    .padding(.leading, 10)
                TextField("password", text: $password)
                    .textContentType(.password)
                    .padding(.vertical, 10)
                    .padding(.leading, 10)
            }
            .cornerRadius(10)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .border(Color.red.opacity(0.1), width:  1)
            .padding(.all, 24)
            
            
            
            HStack {
                LGButton(action: {
                    if !checkId() {
                        showToast = true
                        message = "ID를 입력해주세요."
                        return
                    }
                    
                    if !checkPassword() {
                        showToast = true
                        message = "PASSWORD를 입력해주세요."
                        return
                    }
                }) { Text("Login") }
                
                
                LGButton(action:  {
                    print("sign in")
                }) {
                    Text("Sign in")
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toast(isPresented: $showToast, message: message)
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
