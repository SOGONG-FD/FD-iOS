import Foundation

public struct CreatePostParams: Encodable {
    let id: String
    let title: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case title, content
        case id = "user_id"
    }
}
