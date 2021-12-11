//
//  ContentView.swift
//  weatherWatchOS
//
//  Created by Владислав Космачев.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var watchVM = APIWatch()
    
    var body: some View {
        ScrollView{
            VStack{
                Group{
                    HStack{
                        Text(watchVM.nameCity)
                        Image(systemName: watchVM.aqiStatus).foregroundColor(.green)
                        Spacer()
                    }
                    HStack{
                        Text("\(Int(watchVM.temp))°C").font(.largeTitle)
                        AsyncImage(url: URL(string: "http://openweathermap.org/img/wn/\(watchVM.icon)@2x.png"))
                        Spacer()
                    }
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(watchVM.hourly){ hour in
                                VStack{
                                    Text("\(Converter().converterDateHour(value:hour.dt))")
                                    Spacer()
                                    VStack(spacing:0){
                                        AsyncImage(url: URL(string: "http://openweathermap.org/img/wn/\(hour.icon).png"))
                                        if (hour.snow != 0.0){
                                            Text("\(Int(hour.snow*100.0)) %").foregroundColor(.blue)
                                        }
                                    }
                                    Spacer()
                                    Text("\(Int(hour.temp))°C")
                                }
                            }
                        }
                    }
                    Divider()
                    if (!watchVM.alerts.isEmpty){
                        HStack{
                            Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.yellow)
                            Text("Важные сообщения")
                            Spacer()
                        }
                        ForEach(watchVM.alerts, id: \.self){ alert in
                            HStack{
                                Text("\(alert)")
                                Spacer()
                            }
                        }
                        Divider()
                    }
                    VStack{
                        HStack{
                            Image(systemName: watchVM.aqiStatus).foregroundColor(.green)
                            Text("AQI")
                            Spacer()
                        }
                        HStack{
                            if (watchVM.aqi == 1){
                                Text("Status:Low")
                            } else if (watchVM.aqi > 1 && watchVM.aqi <= 3){
                                Text("Status:Medium")
                            } else {
                                Text("Status:High")
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    Divider()
                }
                HStack{
                    Spacer()
                    VStack{
                        HStack{
                            Image(systemName: "sunrise")
                            Text("Восход")
                        }
                        Text("\(Converter().converterDate(value:watchVM.sunrise))")
                    }
                    Spacer()
                    VStack{
                        HStack{
                            Image(systemName: "sunset")
                            Text("Закат")
                        }
                        Text("\(Converter().converterDate(value:watchVM.sunset))")
                    }
                    Spacer()
                }
                Divider()
                ForEach(watchVM.daily){ daily in
                    HStack{
                        Text("\(Converter().converterDateWeek(value: daily.dt))")
                        Spacer()
                        AsyncImage(url: URL(string: "http://openweathermap.org/img/wn/\(daily.icon).png"))
                        Spacer()
                        Text("\(Int(daily.temp))°C")
                        Text("\(Int(daily.max))°C").foregroundColor(.gray)
                    }
                }
                Group{
                    Divider()
                    VStack{
                        HStack{
                            Image(systemName: "wind")
                            Text("Ветер")
                            Spacer()
                        }
                        HStack{
                            Text("\( Converter().converter2F(value: watchVM.windSpeed))м/с").font(.largeTitle).foregroundColor(.blue)
                            Spacer()
                        }
                    }
                    Divider()
                    VStack{
                        HStack{
                            Image(systemName: "cloud")
                            Text("Облачность")
                            Spacer()
                        }
                        HStack{
                            Text("\(watchVM.clouds)%").font(.largeTitle).foregroundColor(.blue)
                            Spacer()
                        }
                    }
                    Divider()
                    VStack{
                        HStack{
                            Image(systemName: "humidity")
                            Text("Влажность")
                            Spacer()
                        }
                        HStack{
                            Text("\(watchVM.humidity)%").font(.largeTitle).foregroundColor(.blue)
                            Spacer()
                        }
                    }
                    Divider()
                }
                Spacer()
            }
        }.onAppear{
            watchVM.getAirPollution(lat: 55.740424, lon: 52.408949)
            watchVM.getData(lat: 55.740424, lon: 52.408949)
            watchVM.getExtendedData(lat: 55.740424, lon: 52.408949)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
