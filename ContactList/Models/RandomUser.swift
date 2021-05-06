//
//  RandomUser.swift
//  ContactList
//
//  Created by Alexey Efimov on 16.03.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import Foundation

// MARK: - Result
struct User: Codable {
    var gender: String?
    var name: Name?
    var location: Location?
    var email: String?
    var login: Login?
    var dob, registered: Dob?
    var phone, cell: String?
    var id: ID?
    var picture: Picture?
    var nat: String?
    
    init(value: [String: Any]) {
        gender = value["gender"] as? String
        
        let nameDict = value["name"] as? [String: String] ?? [:]
        name = Name(value: nameDict)
        
        let locationDict = value["location"] as? [String: Any] ?? [:]
        location = Location(value: locationDict)
        
        email = value["email"] as? String
        
        let loginDict = value["login"] as? [String: String] ?? [:]
        login = Login(value: loginDict)
        
        let dobDict = value["dob"] as? [String: Any] ?? [:]
        dob = Dob(value: dobDict)
        
        let registeredDict = value["registered"] as? [String: Any] ?? [:]
        registered = Dob(value: registeredDict)
        
        phone = value["phone"] as? String
        cell = value["cell"] as? String
        
        let idDict = value["id"] as? [String: String] ?? [:]
        id = ID(value: idDict)
        
        let pictureDict = value["picture"] as? [String: String] ?? [:]
        picture = Picture(value: pictureDict)
        
        nat = value["nat"] as? String
    }
    
    init(firstName: String, lastName: String) {
        let name = Name(first: firstName, last: lastName)
        self.name = name
    }
    
    static func getRandomUser(from value: Any) -> [User]? {
        guard let value = value as? [String : Any] else { return [] }
        guard let results = value["results"] as? [[String: Any]] else { return [] }
        return results.compactMap { User(value: $0)}
    }
}

// MARK: - Dob
struct Dob: Codable {
    let date: String?
    let age: Int?
    
    init(value: [String: Any]) {
        date = value["date"] as? String
        age = value["age"] as? Int
    }
}

// MARK: - ID
struct ID: Codable {
    let name: String?
    let value: String?
    
    init(value: [String: String]) {
        name = value["name"]
        self.value = value["value"]
    }
}

// MARK: - Location
struct Location: Codable {
    let street: Street?
    let city, state, country: String?
    let postcode: Int?
    let coordinates: Coordinates?
    let timezone: Timezone?
    
    init(value: [String: Any]) {
        let streetDict = value["street"] as? [String: Any] ?? [:]
        street = Street(value: streetDict)
        city = value["city"] as? String
        state = value["state"] as? String
        country = value["country"] as? String
        postcode = value["postcode"] as? Int
        
        let coordinateDict = value["coordinate"] as? [String: String] ?? [:]
        coordinates = Coordinates(value: coordinateDict)
        
        let timezoneDict = value["timezone"] as? [String: String] ?? [:]
        timezone = Timezone(value: timezoneDict)
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String?
    
    init(value: [String: String]) {
        latitude = value["latitude"]
        longitude = value["longitude"]
    }
}

// MARK: - Street
struct Street: Codable {
    let number: Int?
    let name: String?
    
    init(value: [String: Any]) {
        number = value["number"] as? Int
        name = value["name"] as? String
    }
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset, timezoneDescription: String?
    
    init(value: [String: String]) {
        offset = value[CodingKeys.offset.rawValue]
        timezoneDescription = value[CodingKeys.timezoneDescription.rawValue]
    }

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
    
    init(value: [String: String]) {
        uuid = value["uuid"]
        username = value["username"]
        password = value["password"]
        salt = value["salt"]
        md5 = value["md5"]
        sha1 = value["sha1"]
        sha256 = value["sha256"]
    }
}

// MARK: - Name
struct Name: Codable {
    var title, first, last: String?
    
    init(value: [String: String]) {
        title = value["title"]
        first = value["first"]
        last = value["last"]
    }
    
    init(first: String, last: String) {
        self.first = first
        self.last = last
    }
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String?
    
    init(value: [String: String]) {
        large = value["large"]
        medium = value["medium"]
        thumbnail = value["thumbnail"]
    }
}

// MARK: - Constants
enum URLConstants: String {
    case randomUserAPI = "https://randomuser.me/api/"
}

enum Segues: String {
    case showContact = "ShowContact"
}
