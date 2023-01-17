//
//  TookaShitView.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 2/18/22.
//

import SwiftUI

enum PoopTypeDouble: Double, Identifiable, CaseIterable {
    
    var id: UUID {
        return UUID()
    }
        
    case type1 = 1.0
    case type2 = 2.0
    case type3 = 3.0
    case type4 = 4.0
    case type5 = 5.0
    case type6 = 6.0
    case type7 = 7.0

}

extension PoopTypeDouble {
    var title: Double {
        switch self {
            
        case .type1:
            return 1.0
        case .type2:
            return 2.0
        case .type3:
            return 3.0
        case .type4:
            return 4.0
        case .type5:
            return 5.0
        case .type6:
            return 6.0
        case .type7:
            return 7.0
        }
    }
}

enum PoopType: String, Identifiable, CaseIterable {
    
    var id: UUID {
        return UUID()
    }
        
    case type1 = "Type 1"
    case type2 = "Type 2"
    case type3 = "Type 3"
    case type4 = "Type 4"
    case type5 = "Type 5"
    case type6 = "Type 6"
    case type7 = "Type 7"

}

extension PoopType {
    var title: String {
        switch self {
            
        case .type1:
            return "Type 1"
        case .type2:
            return "Type 2"
        case .type3:
            return "Type 3"
        case .type4:
            return "Type 4"
        case .type5:
            return "Type 5"
        case .type6:
            return "Type 6"
        case .type7:
            return "Type 7"
        }
    }
}

enum PoopColor: String, Identifiable, CaseIterable {
//enum PoopColor {

    var id: UUID {
        return UUID()
    }
        
    case green = "Green"
    case yellow = "Yellow"
    case red = "Red"
    case brown = "Brown"
    case black = "Black"
    case white = "White"
    
    func displayColor() -> String {
        self.rawValue.capitalized
    }
}

extension PoopColor {
    
    var title: Color {
        switch self {
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .brown:
            return .brown
        case .black:
            return .black
        case .white:
            return .white
        case .red:
            return .red
        }
    }

}

enum Feeling: String, Identifiable, CaseIterable {
    
    var id: UUID {
        return UUID()
    }
    
    case amazing = "Amazing"
    case good = "Good"
    case neutral = "Neutral"
    case bad = "Bad"
    case painful = "Painful"
    
}

extension Feeling {
    var title: String {
        switch self {
        case .amazing:
            return "Amazing"
        case .good:
            return "Good"
        case .neutral:
            return "Neutral"
        case .bad:
            return "Bad"
        case .painful:
            return "Painful"
        }
    }
}


@available(iOS 15.0, *)
struct TookaShitVIew: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Poop.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) var allTasks: FetchedResults<Poop>
    @State var title: String = ""
    @State var selectedFeeling: Feeling = .neutral
    @State var selectedColor: PoopColor = .brown
    @State var selectedType: PoopType = .type1
    @State var currentDate = Date()
    @Environment(\.dismiss) var dismiss
    
    @State var selectedPoopTypeDouble: PoopTypeDouble = .type1

    
    @Binding var date: Date
    @State private var minute: Double = 0
    
    var imagesArr =  [UIImage(named: "PoopType1"), UIImage(named: "PoopType2"), UIImage(named: "PoopType3"), UIImage(named: "PoopType4"), UIImage(named: "PoopType5"),                 UIImage(named: "PoopType6"), UIImage(named: "PoopType7")]
    var count = 0

    
    init(
        date: Binding<Date>
    ) {
        self._date = date
    }
    
     func saveTask() {
        do {
            let task = Poop(context: viewContext)
            task.poopFeeling = selectedFeeling.rawValue
            task.poopColor = selectedColor.rawValue
            task.poopType = selectedType.rawValue
            task.poopTime = currentDate
            task.dateCreated = date
            task.poopDuration = minute
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func forTrailingZero(temp: Double) -> String {
        var tempVar = String(format: "%g", temp)
        return tempVar
    }
    
    var body: some View {

       ScrollView {
            VStack {
                
            // MARK: - MultipleSelectionList
                
                HStack {
                    Text("Feeling")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.brown)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.bottom, 15)
                .padding(.horizontal)
                
                Picker("Feeling", selection: $selectedFeeling) {
                    ForEach(Feeling.allCases) { feeling in
                        Text(feeling.title)
                            .tag(feeling)
                            .font(.system(size: 16))
                        
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                    
                // MARK: - Poop Color
                
                HStack {
                    Text("Poop Color")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.brown)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.bottom, 15)
                .padding(.horizontal)
                
                    
                HStack(alignment: .center) {
                    ForEach(PoopColor.allCases) { poopColor in
                        ZStack {
                            Circle()
                                .fill(poopColor.title).tag(poopColor)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Circle()
                                        .stroke(selectedColor == poopColor ? Color.blue : Color.black, lineWidth: 2.5)
                                )
                                .onTapGesture {
                                    selectedColor = poopColor
//                                    print(selectedColor)
                                }
                            
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color.blue)
                                .opacity(selectedColor == poopColor ? 1 : 0)
                        }
                    }
                }
                .padding(.bottom, 10)

                                  

                
                // MARK: - Poop Type

                HStack {
                    Text("Poop Type ")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.brown)
                            .cornerRadius(15)
                            .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.bottom, 15)
                .padding(.horizontal)
                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(imagesArr, id: \.self) { img in
//                                VStack {
//                                    Image(uiImage: img!)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 100, height: 100)
//
//
//                                    let imageCount = imagesArr.count - 1
//
//
//                                    Text("Type \(imageCount + 1)")
//                                }
//
//                            }
//                        }
//                    }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        VStack {
                            Image("PoopType1PDF")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text("Type 1")
                                .font(.system(size: 18))
                                .padding(.vertical, -15)
                            
                            if selectedType == .type1 {
                                Image(systemName: "largecircle.fill.circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)

                            } else {
                                Image(systemName: "circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)

                            }
                        }
                        .onTapGesture {
                            selectedType = .type1
                            selectedPoopTypeDouble = .type1
                        }
                        
                        VStack {
                            Image("PoopType2PDF")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text("Type 2")
                                .font(.system(size: 18))
                                .padding(.vertical, -15)
                            
                            if selectedType == .type2 {
                                Image(systemName: "largecircle.fill.circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)


                            } else {
                                Image(systemName: "circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)

                            }
                        }
                        .onTapGesture {
                            selectedType = .type2
                            selectedPoopTypeDouble = .type2
                        }
                        
                        VStack {
                            Image("PoopType3PDF")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text("Type 3")
                                .font(.system(size: 18))
                                .padding(.vertical, -15)
                            
                            if selectedType == .type3 {
                                Image(systemName: "largecircle.fill.circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)


                            } else {
                                Image(systemName: "circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)

                            }
                        }
                        .onTapGesture {
                            selectedType = .type3
                            selectedPoopTypeDouble = .type3
                        }
                        
                        VStack {
                            Image("PoopType4PDF")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text("Type 4")
                                .font(.system(size: 18))
                                .padding(.vertical, -15)
                            
                            
                            if selectedType == .type4 {
                                Image(systemName: "largecircle.fill.circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)


                            } else {
                                Image(systemName: "circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)

                            }
                        }
                        .onTapGesture {
                            selectedType = .type4
                            selectedPoopTypeDouble = .type4
                        }
                        
                        VStack {
                            Image("PoopType5PDF")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text("Type 5")
                                .font(.system(size: 18))
                                .padding(.vertical, -15)
                            
                            if selectedType == .type5 {
                                Image(systemName: "largecircle.fill.circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)


                            } else {
                                Image(systemName: "circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)

                            }

                        }
                        .onTapGesture {
                            selectedType = .type5
                            selectedPoopTypeDouble = .type5
                        }
                        
                        VStack {
                            Image("PoopType6PDF")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text("Type 6")
                                .font(.system(size: 18))
                                .padding(.vertical, -15)
                            
                            if selectedType == .type6 {
                                Image(systemName: "largecircle.fill.circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)


                            } else {
                                Image(systemName: "circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)

                            }

                        }
                        .onTapGesture {
                            selectedType = .type6
                            selectedPoopTypeDouble = .type6
                        }
                        
                        VStack {
                            Image("PoopType7PDF")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text("Type 7")
                                .font(.system(size: 18))
                                .padding(.vertical, -15)
                            
                            if selectedType == .type7 {
                                Image(systemName: "largecircle.fill.circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)


                            } else {
                                Image(systemName: "circle")
                                    .frame(width: 25, height: 25)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color.blue)

                            }

                        }
                        .onTapGesture {
                            selectedType = .type7
                            selectedPoopTypeDouble = .type7
                        }
                    }
                }
                .padding(.bottom, 10)


//                    Spacer()
//
//                    Picker("Type", selection: $selectedType) {
//                        ForEach(PoopType.allCases) { poopType in
//                            Text(poopType.title)
//                                .tag(poopType)
//                        }
//                    }
                    
                
                
                
                // MARK: - Poop Duration
                VStack {
                    HStack {
                        Text("Duration")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.brown)
                            .cornerRadius(15)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    Slider(value: $minute, in: 0...60, step: 1)
                    if minute == 1 || minute == 0 {
                        Text("\(forTrailingZero(temp: minute)) Minute")
                    } else {
                        Text("\(forTrailingZero(temp: minute)) Minutes")
                    }
                }
                .padding(.horizontal)
                
                // MARK: - Time

                HStack {
                    Text("Time")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.brown)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                    
                    Spacer()

                    DatePicker("", selection: $currentDate, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                }
                .padding()
                
                Button("Done") {
                    saveTask()
                    dismiss()
                }
                .font(.system(size: 20))
                .padding()
                .frame(maxWidth: 120, maxHeight: 50)
                .background(Color.brown)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                

            }
            .padding(.vertical)
        }
    }
    
}

//@available(iOS 15.0, *)
//struct TookaShitVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        TookaShitVIew()
//    }
//}
