import XCTest
@testable import OpenAISwift

final class OpenAISwiftTests: XCTestCase {
    
    override func setUp() {
        Auth.apiKey = Secrets.apiKey
    }
    
    override func tearDown() {
        Auth.apiKey = ""
    }
    
    func test_fetchChatCompletion() async throws {
        let (service, payload) = makeSUT()
        
        let response = try await service.fetchChatCompletion(payload: payload)
        
        XCTAssertEqual(response.messages.first?.role, .assistant)
        XCTAssertEqual(response.messages.count, 1)
    }
    
    func test_streamChatCompletion() async throws {
        let (service, payload) = makeSUT()
        
        let stream = await service.streamChatCompletion(payload: payload)
        
        for try await chunk in stream {
            XCTAssertNotEqual(chunk.choices.count, 0)
        }
    }
    
    private func makeSUT() -> (ChatService, CompletionPayload) {
        let service = ChatService()
        let message = Message(role: .user, text: "Who was the first president of the united states?")
        let payload = CompletionPayload(messages: [message], model: .gpt3_5Turbo)
        
        return (service, payload)
    }
}
