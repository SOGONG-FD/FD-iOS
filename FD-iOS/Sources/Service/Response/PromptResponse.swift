import Foundation

public struct PromptResponse: Decodable {
    let userMessage: String
    let botMessage: String

    enum CodingKeys: String, CodingKey {
        case userMessage = "user_message"
        case botMessage = "bot_response"
    }
}

public struct PromptHistoryResponse: Decodable {
    public let message: String
    public let history: [PromptHistoryResponseElement]
}

public struct PromptHistoryResponseElement: Decodable, Hashable {
    public let id: Int
    public let userMessage: String
    public let botMessage: String

    enum CodingKeys: String, CodingKey {
        case id
        case userMessage = "user_message"
        case botMessage = "bot_response"
    }
}
