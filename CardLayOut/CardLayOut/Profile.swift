//
//  Profile.swift
//  CardLayOut
//
//  Created by HARSH TRIVEDI on 08/07/24.
//

import Foundation
struct Profile: Codable {
    let firstName: String
    let lastName: String
    let dateOfBirth: String
    let distanceInMiles: Double
    let country: String
    let city: String
    let aboutMe: String?
    let photoList: [Photo]
    let usersQuestionsList: [UserQuestion]
    let usersInterestList: [UserInterest]
    let verified: Bool
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    var age: Int {
        let dateFormatter = ISO8601DateFormatter()
        let birthDate = dateFormatter.date(from: dateOfBirth) ?? Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthDate, to: Date())
        return components.year ?? 0
    }
}

struct Photo: Codable {
    let imageUrl: String
    let positionInPics: Int
    let profilePic: Bool
}

struct UserQuestion: Codable {
    let answer: String
    let question: String
}

struct UserInterest: Codable {
    let interestTitle: String
    let iconUrl: String
}
