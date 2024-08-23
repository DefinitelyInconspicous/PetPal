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
    @State var weightG: [WeightCell] = []
    @State var streakDays = 2
    @State var col = Color(red: 0/255, green: 0/255, blue: 0/255)
    @StateObject var camera = CameraModel()
    @StateObject private var photoManager = PhotoManager()
    
    let placeholder = "placeholder"
    
    @Forever("pet") var pet = Pet(
        petName: "Rufus",
        petType: "Dog",
        breed: "Golden Retriever",
        weight: 10.0,
        diet: "Omnivorous",
        gender: .male,
        birthDate: Date.now,
        sterile: false,
        age: 0
    )
    
    // New State variables for weight and date selection
    @State private var selectedDate = Date()
    @State private var newWeight: Double = 10.0
    
    var body: some View {
        NavigationStack {
            
            VStack {
                HStack {
                    Text("Pet")
                        .font(.system(size: 50, design: .rounded))
                        .fontWeight(.heavy)
                        .padding()
                        .foregroundColor(textColour)
                    Spacer(minLength: 0) // Reduce space between elements
                    if let lastPhoto = photoManager.photos.last, let image = UIImage(data: lastPhoto.imageData) {
                        Image(uiImage: image)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .clipShape(Circle())
                                                    .frame(width: 80, height: 80) // Adjust image size
                                                    .padding(.horizontal, 10)
                    } else {
                        Image(placeholder)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80) // Adjust image size
                            .padding(.horizontal, 10)
                    }
                    Spacer(minLength: 0) // Reduce space between elements
                    Text("Pal")
                        .font(.system(size: 50, design: .rounded))
                        .fontWeight(.heavy)
                        .padding()
                        .foregroundColor(textColour)
                }
                .padding(.horizontal)
                    
                
//                Rectangle()
//                    .frame(height: 4)
//                    .foregroundColor(textColour)
//
//                Text("Welcome Back \(username)!")
//                    .font(.title2)
//                    .fontWeight(.medium)
                
                VStack {
                    Text("Your Pet's Weight over the Months")
                        .font(.headline)
                        .foregroundStyle(.black)
                    
                    Chart {
                        ForEach(weightG) { cell in
                            LineMark(
                                x: .value("Date", cell.date, unit: .day),
                                y: .value("Weight", cell.weight)
                            )
                            .foregroundStyle(
                                (cell.weight >= 27 || cell.weight <= 10)
                                ? Color(red: 204/255, green: 41/255, blue: 0/255)
                                : Color.black
                            )
                        }
                    }
                    .frame(height: 100)
                    
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.compact)

                    
                    Stepper("Weight: \(newWeight, specifier: "%.1f") kg", value: $newWeight, step: 0.5)

                    
                    Button(action: {
                        let newCell = WeightCell(weight: Int(newWeight), date: selectedDate)
                        weightG.append(newCell)
                    }) {
                        Text("Add Weight")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(rectColour)
                .cornerRadius(20)
                
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
                            }
                        }
                    }
                }
            }
            .onAppear {
                // Load photos when the view appears
                photoManager.loadPhotos()
            }
            .padding(.top)
        }
    }
}

#Preview {
    HomePage()
}
