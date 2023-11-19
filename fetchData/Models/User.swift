import Foundation

struct User: Codable {
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
    
    enum CodingKeys: String, CodingKey {
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
    
    init(id: Int?, uid: String?, password: String?, name: String?, surname: String?, username: String?, email: String?, avatar: String?, gender: String?, phoneNumber: String?, socialInsuranceNumber: String?, dateOfBirth: String?, employment: Employment?, address: Address?, creditCard: CreditCard?, subscription: Subscription?) {
        self.id = id
        self.uid = uid
        self.password = password
        self.name = name
        self.surname = surname
        self.username = username
        self.email = email
        self.avatar = avatar
        self.gender = gender
        self.phoneNumber = phoneNumber
        self.socialInsuranceNumber = socialInsuranceNumber
        self.dateOfBirth = dateOfBirth
        self.employment = employment
        self.address = address
        self.creditCard = creditCard
        self.subscription = subscription
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.uid = try container.decodeIfPresent(String.self, forKey: .uid)
        self.password = try container.decodeIfPresent(String.self, forKey: .password)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.surname = try container.decodeIfPresent(String.self, forKey: .surname)
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.socialInsuranceNumber = try container.decodeIfPresent(String.self, forKey: .socialInsuranceNumber)
        self.dateOfBirth = try container.decodeIfPresent(String.self, forKey: .dateOfBirth)
        self.creditCard = try container.decodeIfPresent(CreditCard.self, forKey: .creditCard)
        self.employment = try container.decodeIfPresent(Employment.self, forKey: .employment)
        self.address = try container.decodeIfPresent(Address.self, forKey: .address)
        self.subscription = try container.decodeIfPresent(Subscription.self, forKey: .subscription)
    }
    
    init(userData: [String: Any]) {
        id = userData["id"] as? Int ?? 0
        uid = userData["uid"] as? String ?? ""
        password = userData["password"] as? String ?? ""
        name = userData[CodingKeys.name.rawValue] as? String ?? ""
        surname = userData[CodingKeys.surname.rawValue] as? String ?? ""
        username = userData["username"] as? String ?? ""
        email = userData["email"] as? String ?? ""
        avatar = userData["avatar"] as? String ?? ""
        gender = userData["gender"] as? String ?? ""
        phoneNumber = userData["phoneNumber"] as? String ?? ""
        socialInsuranceNumber = userData["socialInsuranceNumber"] as? String ?? ""
        dateOfBirth = userData["dateOfBirth"] as? String ?? ""
        employment = userData["employment"] as? Employment
        address = userData["address"] as? Address
        creditCard = userData["creditCard"] as? CreditCard
        subscription = userData["subscription"] as? Subscription
    }
    
    static func getUsers(from value: Any) -> [User] {
        guard let dataUsers = value as? [[String: Any]] else { return []}

        return dataUsers.compactMap {
            User(userData: $0)
        }
    }
}

struct Employment: Codable {
    let title: String?
    let key_skill: String?
}

struct Address: Codable {
    let city: String?
    let street_name: String?
    let street_address: String?
    let zip_code: String?
    let state: String?
    let country: String?
    let coordinates: Coordinates?
}

struct Coordinates: Codable {
    let lat: Double?
    let lng: Double?
}

struct CreditCard: Codable {
    let ccNumber: String?
    
    private enum CodingKeys: String, CodingKey {
        case ccNumber = "cc_number"
    }
}

struct Subscription: Codable {
    let plan: String?
    let status: String?
    let paymentMethod: String?
    let term: String?
    
    private enum CodingKeys: String, CodingKey {
        case paymentMethod = "payment_method"
        case plan, status, term
    }
}

