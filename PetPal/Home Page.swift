import SwiftUI
import Forever
import Charts

struct WeightCell: Identifiable, Encodable, Decodable {
    var id = UUID()
    var weight: Int
    var date: Date
}

struct HomePage: View {
    var textColour = Color(red: 34 / 255, green: 53 / 255, blue: 64 / 255)
    var rectColour = Color(red: 242/255, green: 241/255, blue: 216/255)
    
    @State var username = "Benji"
    //var weightGraph: [Double] = [20,23,18,28,32,14,29,90,49,34,46,29,19,20,28,38,41,49,46,54,61]
    //@State var timeGraph = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21]
    //@State var weightData: [weightCell]
    @State var weightCount = 0
    @Forever("weightg") var weightG: [data] = []
    @State var streakDays = 2
    @State var col = Color(red: 0/255, green: 0/255, blue: 0/255)
    @StateObject var camera = CameraModel()
    @StateObject private var photoManager = PhotoManager()
    let placeholder = ["placeholder", "placeholder2"]
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    Text("Pet")
                        .font(Font.system(size:60, design: .rounded))
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .padding()
                        .foregroundColor(textColour)
                    Spacer()
                    if let lastPhoto = photoManager.photos.last, let image = UIImage(data: lastPhoto.imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .padding()
                        
                    } else {
                        Image(placeholder[Int.random(in: 0..<placeholder.count)])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .padding()
                    }
                    // MARK: - Add Daily Sticker
                  
                    Spacer()
                    Text("Pal")
                        .font(Font.system(size:60, design: .rounded))
                        .fontWeight(.heavy)
                        .fontDesign(.rounded)
                        .padding()
                        .foregroundColor(textColour)
                }
                Rectangle()
                    .frame(height: 4)
                    .foregroundColor(textColour)
                Text("Welcome Back \(username)!")
                    .font(.title2)
                    .fontWeight(.medium)
                
                
                VStack {
                    Text("Your Pet's Weight over the Months")
                        .font(.headline)
                        .foregroundStyle(.black)
                    Chart {
                        ForEach(0..<weightG.count, id: \.self ) { index in
                            LineMark(
                                x: .value("Date", weightG.count > 1 ? weightG[index].weigh : 0),
                                y: .value("Weight",weightG.count > 1 ? weightG[index].time : 0)
                            )
                            //.foregroundStyle((weightG[index] >= 27) || (weightG[index] <= 10) ? Color(red:204/255, green:41/255, blue:0/255) : Color(red: 0/255, green: 0/255, blue: 0/255))
                        }
                    }
                    .frame(height: 120)
//                    .onAppear() {
//                        if (weightGraph[index] > 27) || (weightGraph[index] < 10) {
//                            col = Color(red:204/255, green:41/255, blue:0/255)
//                        } else {
//                             col = Color(red: 0/255, green: 0/255, blue: 0/255)
//                        }
//                    }
                    
                }
                .padding()
                .background(rectColour)
                .cornerRadius(20)
                .padding()
              
                VStack {
                    HStack {
                        
                        NavigationLink {
                            PetographyView()
                                .environmentObject(photoManager)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(red: 186/255, green: 213/255, blue: 201/255))
                                    .cornerRadius(20)
                                    .frame(width: 150, height: 120)
                                VStack {
                                    HStack {
                                        Image(systemName: "flame.fill")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 50))
                                        Text("\(streakDays) \n Days")
                                            .foregroundStyle(.black)
                                            .fontWeight(.semibold)
                                    }
                                    Text("Petography")
                                        .foregroundStyle(.black)
                                        .bold()
                                        .font(.title2)
                                }
                            }
                            
                        }
                        NavigationLink {
                            SettingsView()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(red: 186/255, green: 213/255, blue: 201/255))
                                    .cornerRadius(20)
                                    .frame(width: 150, height: 120)
                                VStack(alignment: .center) {
                                    HStack {
                                        Image(systemName: "gear")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 50))
                                    }
                                    Text("Settings")
                                        .foregroundStyle(.black)
                                        .bold()
                                        .font(.title2)
                                }
                                //.frame(width: 150, height: 120)
                                
                            }
                            
                        }
                        
                    }
                    HStack {
                        NavigationLink {
                            PassportScreen1()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(red: 186/255, green: 213/255, blue: 201/255))
                                    .cornerRadius(20)
                                    .frame(width: 150, height: 120)
                                VStack(alignment: .center) {
                                    HStack {
                                        Image(systemName: "book.fill")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 50))
                                    }
                                    Text("Passport")
                                        .foregroundStyle(.black)
                                        .bold()
                                        .font(.title2)
                                }
                                //.frame(width: 150, height: 120)
                                
                            }
                            
                        }

                    }
                }
            }
            
            Spacer()
                .onAppear {
                    // Load photos when the view appears
                    photoManager.loadPhotos()
                }
        }
    }
        
}


#Preview {
    Home_Page()
}












