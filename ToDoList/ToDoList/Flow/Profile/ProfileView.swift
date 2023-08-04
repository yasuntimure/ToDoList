//
//  ProfileView.swift
//  ToDoList
//
//  Created by Eyüp on 2023-07-10.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {

    @EnvironmentObject var viewModel: MainViewModel

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ProfileImagePicker()
                        .padding([.leading, .top], 20)


                    VStack (alignment: .trailing, spacing: 2) {
                        VStack (alignment: .leading, spacing: 5) {

                            Text(viewModel.userName)
                                .font(.system(size: 22))
                                .bold()

                            HStack {
                                Text("Joined:")
                                    .bold()
                                Text(viewModel.joinDate)
                            }
                            .font(.system(size: 14))
                        }
                        .padding(.top)

                        SecondaryButton(title: "Logout") {
                            viewModel.logout {
                                withAnimation {
                                    viewModel.userId = ""
                                }
                            }
                        }
                    }
                    .padding(.leading)

                    Spacer()
                }
                .padding(.top)

                CarouselView(lists: viewModel.lists)
                    .padding(.top, 50)

                Spacer()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(viewModel.errorMessage))
            }

        }
        .environmentObject(viewModel)

    }


}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(MainViewModel())
    }
}
