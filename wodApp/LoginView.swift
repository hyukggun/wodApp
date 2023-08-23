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
    @State var signInResult: Bool = false
    @State var signUp: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome back to our app!!")
                VStack {
                    TextField("enter your email", text: $id)
                        .textInputAutocapitalization(.never)
                        .padding(10)
                    SecureField("password", text: $password)
                        .padding(10)
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
                        
                        Task {
                            let result = await AuthManagerImpl().signIn(email: id, password: password)
                            showToast = true
                            if result {
                                message = "로그인 성공"
                            } else {
                                message = "로그인 실패"
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                signInResult = result
                            }
                        }
                    }) { Text("Login") }
                        
                    
                    LGButton(action:  {
                        print("sign in")
                        signUp = true
                    }) {
                        Text("Sign in")
                    }
                }
                Text("This content is by papayetoo")
                    .offset(y: 50)
                //                NavigationLink(destination: HomeView(),
                //                               isActive: $signInResult) {
                //                    EmptyView()
                //                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(isPresented: $signInResult, destination: { HomeView() })
            .navigationDestination(isPresented: $signUp, destination: { SignUpView() })
        }
        .edgesIgnoringSafeArea(.all)
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
        return !password.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
