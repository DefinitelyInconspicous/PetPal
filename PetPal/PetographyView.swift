import SwiftUI

struct PetographyView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Petography")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading) // Padding on the left side
                
                Spacer() // Pushes the button to the far right
                NavigationLink(destination: CameraView()){
                    Button(action: {
                        // Add your action here
                    }) {
                        Image(systemName: "camera.fill")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .padding(.trailing) // Padding on the right side
                }
            }
            .padding([.top, .horizontal]) // Add padding around the HStack
            Text("Record memories with your pets here, and reminisce the valuable ones with them!")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.bottom)

            Spacer() // Pushes the content up

        }
    }
}

#Preview {
    PetographyView()
}

