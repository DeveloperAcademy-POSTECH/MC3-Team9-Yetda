//
//  Location.swift
//  Yetda
//
//  Created by rbwo on 2022/07/30.
//

import Foundation

struct SiteModel {
    var name: String
    var latitude: Double
    var longitude: Double
}

extension SiteModel {
    static let locationList: [Location] = [Location(name: "Hokkaido" , latitude: 43.43230, longitude: 142.91759), Location(name: "Aomori", latitude: 40.82268, longitude: 140.74693), Location(name: "Iwate", latitude: 39.59045, longitude: 141.38413), Location(name: "Miyagi", latitude: 38.42251, longitude: 140.84658), Location(name: "Akita", latitude: 39.71996, longitude: 140.10355), Location(name: "Yamagata", latitude: 38.25534, longitude: 140.33958), Location(name: "Fukushima", latitude: 37.38398, longitude: 140.13314), Location(name: "Ibaraki", latitude: 36.29798, longitude: 140.19305), Location(name: "Tochigi", latitude: 36.38245, longitude: 139.73410), Location(name: "Gunma", latitude: 36.52200, longitude: 138.91945), Location(name: "Saitama", latitude: 35.86167, longitude: 139.64554), Location(name: "Chiba", latitude: 35.60747, longitude: 140.10663), Location(name: "Tokyo", latitude: 35.68951, longitude: 139.69170), Location(name: "Kanagawa", latitude: 35.43592, longitude: 139.29608), Location(name: "Niigata", latitude: 37.91620, longitude: 139.03635), Location(name: "Toyama", latitude: 36.69588, longitude: 137.21373), Location(name: "Ishikawa", latitude: 37.13838, longitude: 136.81891), Location(name: "Fukui", latitude: 36.06408, longitude: 136.21962), Location(name: "Yamanashi", latitude: 35.69332, longitude: 138.68729), Location(name: "Nagano", latitude: 36.64859, longitude: 138.19476), Location(name: "Gifu", latitude: 35.42624, longitude: 136.75982), Location(name: "Shizuoka", latitude: 34.97516, longitude: 138.38324), Location(name: "Aichi", latitude: 35.01043, longitude: 137.29403), Location(name: "Mie", latitude: 34.38581, longitude: 136.50700), Location(name: "Shiga", latitude: 35.28312, longitude: 135.98280), Location(name: "Kyoto", latitude: 35.01170, longitude: 135.76816), Location(name: "Osaka", latitude: 34.62068, longitude: 135.51644), Location(name: "Hyogo", latitude: 35.14497, longitude: 134.81086), Location(name: "Nara", latitude: 34.68509, longitude: 135.80483), Location(name: "Wakayama", latitude: 33.89512, longitude: 135.38594), Location(name: "Tottori", latitude: 35.49442, longitude: 134.22218), Location(name: "Shimane", latitude: 34.94438, longitude: 132.38305), Location(name: "Okayama", latitude: 34.65515, longitude: 133.91970), Location(name: "Hiroshima", latitude: 34.38524, longitude: 132.45534), Location(name: "Yamaguchi", latitude: 34.25180, longitude: 131.47880), Location(name: "Tokushima", latitude: 34.07015, longitude: 134.55481), Location(name: "Kagawa", latitude: 34.20627, longitude: 134.01555), Location(name: "Ehime", latitude: 33.57074, longitude: 132.81410), Location(name: "Kochi", latitude: 33.30227, longitude: 133.06019), Location(name: "Fukuoka", latitude: 33.59010, longitude: 130.40167), Location(name: "Saga", latitude: 33.29804, longitude: 130.06319), Location(name: "Nagasaki", latitude: 32.75033, longitude: 129.87771), Location(name: "Kumamoto", latitude: 32.80320, longitude: 130.70802), Location(name: "Oita", latitude: 33.23965, longitude: 131.60911), Location(name: "Miyazaki", latitude: 31.90772, longitude: 131.42020), Location(name: "Kagoshima", latitude: 31.59668, longitude: 130.55739), Location(name: "Okinawa", latitude: 26.33429, longitude: 127.80560)]
}
