//
//  ContentView.swift
//  wodApp
//
//  Created by 최최광현 on 2023/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var mainImage: UIImage = UIImage()
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image(uiImage: mainImage)
                        .resizable()
                        .frame(alignment: .top)
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    ActionSheet() {
                        LoginView()
                    }
                    .offset(y: mainImage.size.height + 50)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
                .cornerRadius(10)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            guard let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwV3u84ju4li8YemjAk-SQ7aBBHO4N2TJNhA&usqp=CAU") else {
                print("url in nil")
                mainImage = UIImage()
                return
            }
            Task {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard let response = response as? HTTPURLResponse else {
                        mainImage = UIImage()
                        return
                    }
                    print(response.statusCode)
                    guard let image = UIImage(data: data) else { return }
                    mainImage = image
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private struct ActionSheet: View {
    @State var destination: () -> LoginView
    
    init(destination: @escaping () -> LoginView) {
        self.destination = destination
    }
    
    var body: some View {
        VStack(spacing : 15) {
            Text("Shape Your body!!")
                .frame(height: 50)
            Spacer().frame(height: 10)
            NavigationLink(destination: destination) {
                Text("Login")
                    .foregroundColor(Color.pink)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .padding(.horizontal)
        .padding(.top, 20)
        .background(Color.white)
        .cornerRadius(30)
        .edgesIgnoringSafeArea(.bottom)
    }
}

