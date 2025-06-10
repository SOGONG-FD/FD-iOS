import Foundation

struct AllPostResponse: Decodable, Hashable {
    let success: Bool
    let count: Int
    let posts: [PostResponseElement]
}

struct PostResponse: Decodable, Hashable {
    let success: Bool
    let post: PostResponseElement
}

public struct PostResponseElement: Decodable, Hashable {
    public var postID: String
    public var userID: String
    public var title: String
    public var content: String
    public var createdAt: String
    public var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case userID = "user_id"
        case title
        case content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

public struct PostCreateSuccessResponse: Decodable, Hashable {
    public var success: Bool
    public var postID: String
    public var message: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case postID = "post_id"
    }
}
