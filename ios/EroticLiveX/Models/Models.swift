import Foundation

struct UserModel: Codable {
    let uid: String
    let email: String
    let displayName: String?
    let photoURL: String?
    let createdAt: Date?
    let updatedAt: Date?
    let isVerified: Bool
    
    enum CodingKeys: String, CodingKey {
        case uid
        case email
        case displayName
        case photoURL
        case createdAt
        case updatedAt
        case isVerified
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "uid": uid,
            "email": email,
            "isVerified": isVerified
        ]
        
        if let displayName = displayName {
            dict["displayName"] = displayName
        }
        if let photoURL = photoURL {
            dict["photoURL"] = photoURL
        }
        if let createdAt = createdAt {
            dict["createdAt"] = createdAt
        }
        if let updatedAt = updatedAt {
            dict["updatedAt"] = updatedAt
        }
        
        return dict
    }
}

struct StreamModel: Codable {
    let id: String
    let creatorId: String
    let title: String
    let description: String?
    let thumbnailURL: String?
    let isLive: Bool
    let viewers: Int
    let createdAt: Date
}

struct MessageModel: Codable {
    let id: String
    let senderId: String
    let receiverId: String
    let content: String
    let timestamp: Date
    let isRead: Bool
}
