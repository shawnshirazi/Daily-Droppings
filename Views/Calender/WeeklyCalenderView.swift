//
//  WeeklyCalenderView.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 2/18/22.
//

import SwiftUI
import CoreData

@available(iOS 15.0, *)
struct weeklyCalenderView: View {
    
    private let calender: Calendar
    private let monthDayFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    
    @State var selectedDate = Self.now
    private static var now = Date()
    
    init(calender: Calendar) {
        self.calender = calender
        self.monthDayFormatter = DateFormatter(dateFormat: "MM/dd", calender: calender)
        self.dayFormatter = DateFormatter(dateFormat: "d", calender: calender)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calender: calender)
    }
    
    var body: some View {
        CustomNavView {
            VStack {
                CalenderWeekListView(
                    calender: calender,
                    date: $selectedDate,
                    content: { date in
                        Button(action: { selectedDate = date }) {
                            Text("00")
                                .font(.system(size: 13))
                                .padding(8)
                                .foregroundColor(.clear)
                                .overlay(
                                    Text(dayFormatter.string(from: date))
                                        .foregroundColor(
                                            calender.isDate(date, inSameDayAs: selectedDate)
                                            ? Color.black
                                            : calender.isDateInToday(date) ? .blue
                                            : .gray
                                        )
                                )
                                .overlay(
                                    Circle()
                                        .foregroundColor(.gray.opacity(0.38))
                                        .opacity(calender.isDate(date, inSameDayAs:
                                                                    selectedDate) ? 1 : 0)
                                )
                        }
                    },
                    header: { date in
                        Text("00")
                            .font(.system(size: 13))
                            .padding(8)
                            .foregroundColor(.clear)
                            .overlay(
                                Text(weekDayFormatter.string(from: date))
                                    .font(.system(size: 15))
                            )
                    },
                    title: { date in
                        HStack {
                            Text(monthDayFormatter.string(from: selectedDate))
                                .font(.headline)
                                .padding()
                            Spacer()
                        }
                        .padding(.bottom, 6)
                    },
                    weekSwitcher: { date in
                        Button {
                            withAnimation {
                                guard let newDate = calender.date (
                                    byAdding: .weekOfMonth,
                                    value: -1,
                                    to: selectedDate
                                ) else {
                                    return
                                }
                                
                                selectedDate = newDate
                            }
                            
                        } label: {
                            Label(
                                title: { Text("Previous") },
                                icon: { Image(systemName: "chevron.left")}
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                        }
                        Button {
                            
                            withAnimation {
                                guard let newDate = calender.date (
                                    byAdding: .weekOfMonth,
                                    value: +1,
                                    to: selectedDate
                                ) else {
                                    return
                                }
                                
                                selectedDate = newDate
                            }
                            
                        } label: {
                            Label(
                                title: { Text("Next") },
                                icon: { Image(systemName: "chevron.right")}
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                        }
                    }
                )
                
            }
            .padding()
            .customNavigationTitle("Daily Droppings")
            .CustomNavBarBackButtonHidden(true)
        }
    }
}

@available(iOS 15.0, *)
struct weeklyCalenderView_Previews: PreviewProvider {
    static var previews: some View {
        weeklyCalenderView(calender: Calendar(identifier: .gregorian))
    }
}

@available(iOS 15.0, *)
struct CalenderWeekListView<Day: View, Header: View, Title: View, WeekSwitcher: View>: View {
    private var calender: Calendar
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let header: (Date) -> Header
    private let title: (Date) -> Title
    private let weekSwitcher: (Date) -> WeekSwitcher
                
    private let daysInWeek = 7

    init(
        calender: Calendar,
        date: Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        @ViewBuilder header: @escaping (Date) -> Header,
        @ViewBuilder title: @escaping (Date) -> Title,
        @ViewBuilder weekSwitcher: @escaping (Date) -> WeekSwitcher
    ) {
        self.calender = calender
        self._date = date
        self.content = content
        self.header = header
        self.title = title
        self.weekSwitcher = weekSwitcher
        UITableView.appearance().backgroundColor = .clear
    }
    
    let persistentContainer = CoreDataManager.shared.persistenceContainer
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Poop.entity(), sortDescriptors: [NSSortDescriptor(key: "poopTime", ascending: true)]) private var allTasks: FetchedResults<Poop>
    
    @State private var showingSheet = false
    @State private var showEdit = false

    
    func poopColor(_ value: String) -> Color {
        let poopColor = PoopColor(rawValue: value)
        
        switch poopColor {
            case .green:
                return Color.green
            case .yellow:
                return Color.yellow
            case .red:
                return Color.red
            case .brown:
                return Color.brown
            case .black:
                return Color.black
            case .white:
                return Color.white
            default:
                return Color.brown
        }
    }
    
    private func deletePoop(at offsets: IndexSet) {
        for offset in offsets {
            let task = allTasks[offset]
            viewContext.delete(task)
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
        
    var body: some View {
        let month = date.startOfMoneth(using: calender)
        let days = makeDays()
                                
        GeometryReader { g in
                VStack {
                        VStack {
                            HStack {
                                self.title(month)
                                self.weekSwitcher(month)
                            }
                            HStack(spacing: 30) {
                                ForEach(days.prefix(daysInWeek), id: \.self, content: header)
                            }
                            HStack(spacing: 30) {
                                ForEach(days, id: \.self) { date in
                                    content(date)
                                    
                                }
                            }
                            
                            Divider()
                        }
                    
                    ScrollView (showsIndicators: false) {
                            
                        HStack {

                            Button(action: {
                                showingSheet.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    
                                    Text("Add Poop")
                                        .font(.system(size: 18))
                                        .bold()
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.brown)
                                .cornerRadius(15)
                                .foregroundColor(.white)
                            }
                            .sheet(isPresented: $showingSheet) {
                                TookaShitVIew(date: $date)
                            }
                            
                            
                            Spacer()
                            
                            Button(action: {
                                showEdit.toggle()
                            }) {
                                if showEdit {
                                    HStack {
                                        
                                        Text("Done")
                                            .font(.system(size: 18))
                                            .bold()
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .cornerRadius(16)

                                } else {
                                    HStack {
                                        Image(systemName: "trash.fill")
                                        
                                        Text("Edit")
                                            .font(.system(size: 18))
                                            .bold()
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .cornerRadius(16)
                                }

                            }
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.vertical)
                                            
                        VStack {
                            ForEach(allTasks) { task in
                                if date.get(.day) == task.dateCreated!.get(.day) &&
                                   date.get(.month) == task.dateCreated!.get(.month) &&
                                   date.get(.year) == task.dateCreated!.get(.year) {
                                                                                                                
                                    VStack(alignment: .leading) {
                                        HStack {
                                            HStack {
                                                Image(systemName: "clock.fill")
                                                      .foregroundColor(.black)
                                                      .padding(.trailing, 4)

                                                Text(task.poopTime ?? Date(), style: .time)
                                                    .font(.system(size: 18))
                                                    .fontWeight(.semibold)

                                            }
                                            .padding(.leading, 8)
                                            .padding(.bottom, -3)

                                            Spacer()

                                            if showEdit {
                                                Button(action: {
                                                  viewContext.delete(task)
                                                  try? viewContext.save()
                                                }) {
                                                  Image(systemName: "xmark.circle")
                                                        .foregroundColor(.white)
                                                        .background(Color.red)
                                                        .cornerRadius(15)
                                                        .padding(.bottom, -3)
                                                }
                                            }

                                        }
                                        .padding(.top)
                                        
                                        Divider()
                                            .padding(.bottom, -5)

                                        HStack(spacing: 20) {
                                            VStack {
                                                HStack {
                                                    Image(systemName: "person.fill")
                                                        .frame(width: 35, height: 35)

                                                    Text(task.poopFeeling ?? "")
                                                        .font(.system(size: 16))
                                                        .fontWeight(.medium)

                                                }
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.bottom, -10)

                                                
                                                HStack {
                                                    Image(systemName: "staroflife.fill")
                                                        .frame(width: 35, height: 35)


                                                    Text(task.poopType ?? "")
                                                        .font(.system(size: 16))
                                                        .fontWeight(.medium)
                                                }
                                                .frame(maxWidth: .infinity, alignment: .leading)


                                            }
                                                
                                            VStack {
                                                HStack {
                                                    Image(systemName: "eyedropper")
                                                        .frame(width: 35, height: 35)

                                                    Circle()
                                                        .fill(poopColor(task.poopColor ?? ""))
                                                        .frame(width: 15, height: 15)

                                                }
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .padding(.bottom, -10)
                                                .padding(.top, 4)

                                                
                                                HStack {
                                                                                            
                                                    Image("SittingToiletPDF")
                                                        .resizable()
                                                        .frame(width: 35, height: 35)
                                                        .foregroundColor(.black)
                                                        .padding(.leading, 30)

                                                    Text(String(format: "%.0f", task.poopDuration))
                                                        .font(.system(size: 16))
                                                        .fontWeight(.medium)
                                                        .padding(.leading, -2)

                                                    
                                                    Text(" min")
                                                        .font(.system(size: 15))
                                                        .padding(.leading, -8)
                                                }
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                
                                            }

                                        }
                                        .padding(.bottom, 10)
                                    }
                                    
                                }
                            }
                            .padding()
                            .frame(height: g.size.height / 5.5)
                            .background(Color.lightGray)
                            .cornerRadius(16)
                            
                        }
                        .frame(width: g.size.width)
                    }


                }
        }
    }
    
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
}

//Helper
@available(iOS 15.0, *)
private extension CalenderWeekListView {
    func makeDays() -> [Date] {
        guard let firstWeek = calender.dateInterval(of: .weekOfMonth, for: date),
                let lastWeek = calender.dateInterval(of: .weekOfMonth, for: firstWeek.end - 1)
        else {
            return []
        }
        let dateInterval = DateInterval(start: firstWeek.start, end: lastWeek.end)
        
        return calender.generateDays(for: dateInterval)
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

private extension Calendar {
    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates = [dateInterval.start]
        
        enumerateDates(
            startingAfter: dateInterval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            guard let date = date else { return }
            
            guard date < dateInterval.end else {
                stop = true
                return
            }
            
            dates.append(date)
            
        }
        
        return dates
    }
    
    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(
            for: dateInterval,
               matching: dateComponents([.hour, .minute, .second], from: dateInterval.start))
    }
}

private extension Date {
    func startOfMoneth(using calender: Calendar) -> Date {
        calender.date(from: calender.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}


private extension DateFormatter {
    convenience init(dateFormat: String, calender: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calender
        self.locale = Locale(identifier: "js_JP")
    }
}

