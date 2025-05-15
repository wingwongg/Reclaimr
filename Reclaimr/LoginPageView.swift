//
//  LoginPageView.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI

struct LoginPageView : View {
    var body: some View {
        VStack() {
            Spacer()
            
            VStack(alignment: .center) {
                // icon
                Image(systemName: "person.3.fill")
                    .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: 50)
                    .foregroundStyle(.gray)
                
                // login and password
                TextField("Username", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/).border(.black)
                SecureField(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/"Password"/*@END_MENU_TOKEN@*/, text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("Apple")/*@END_MENU_TOKEN@*/).border(.black)
                
                // login button
                Button("Login") {
                    // login
                }
                .padding(.horizontal, 10.0)
                .padding(.vertical, 5.0)
                .background(Rectangle().foregroundColor(.green))
                .cornerRadius(5)
                
                // forget password
                Button("Forget Password?") {
                    // forget password
                }
            }
            .padding(100)
            
            Spacer()
            
            VStack() {
                // other options
                Button("Sign in with Google") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .padding(15)
                .background(Rectangle().foregroundColor(.green))
            
                Button("Apple") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .padding(15)
                .background(Rectangle().foregroundColor(.green))
                
                Button("Facebook") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .padding(15)
                .background(Rectangle().foregroundColor(.green))
                
                Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .padding(15)
                .background(Rectangle().foregroundColor(.green))
            }
            Spacer()
        }
    }
}

#Preview {
    LoginPageView()
}
