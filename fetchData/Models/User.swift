import Foundation

struct User: Decodable {
    let id: Int?
    let uid: String?
    let password: String?
    let name: String?
    let surname: String?
    let username: String?
    let email: String?
    let avatar: String?
    let gender: String?
    let phoneNumber: String?
    let socialInsuranceNumber: String?
    let dateOfBirth: String?
    let employment: Employment?
    let address: Address?
    let creditCard: CreditCard?
    let subscription: Subscription?
    
    private enum CodingKeys: String, CodingKey {
        case id, uid, password
        case name = "first_name"
        case surname = "last_name"
        case phoneNumber = "phone_number"
        case username, email, avatar, gender
        case socialInsuranceNumber = "social_insurance_number"
        case dateOfBirth = "date_of_birth"
        case creditCard = "credit_card"
        case employment, address, subscription
    }
    
    var fullName: String {
        "\(name ?? "") \(surname ?? "")"
    }
}

struct Employment: Decodable {
    let title: String?
    let key_skill: String?
}

struct Address: Decodable {
    let city: String?
    let street_name: String?
    let street_address: String?
    let zip_code: String?
    let state: String?
    let country: String?
    let coordinates: Coordinates?
}

struct Coordinates: Decodable {
    let lat: Double?
    let lng: Double?
}

struct CreditCard: Decodable {
    let ccNumber: String?
    
    private enum CodingKeys: String, CodingKey {
        case ccNumber = "cc_number"
    }
}

struct Subscription: Decodable {
    let plan: String?
    let status: String?
    let paymentMethod: String?
    let term: String?
    
    private enum CodingKeys: String, CodingKey {
        case paymentMethod = "payment_method"
        case plan, status, term
    }
}

