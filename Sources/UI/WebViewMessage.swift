//
//  WebViewMessage.swift
//  Told
//
//  Created by Jérémy Magnier on 21/01/2025.
//

import CoreGraphics
import Foundation

private extension WebViewMessage {
    enum MessageType {
        static let isLoaded: String = "IS_LOADED"
        static let heightChange: String = "HEIGHT_CHANGE"
        static let updatePosition: String = "UPDATE_POSITION"
        static let close: String = "CLOSE"
        static let closeCalendar: String = "CLOSE_CALENDAR"
        static let addCookie: String = "ADD_COOKIE"
        static let launchCalendar: String = "LAUNCH_CALENDAR"
        static let openLink: String = "OPEN_LINK"
        static let replaceURL: String = "REPLACE_URL"
    }
}

extension WebViewMessage {
    struct Calendar: Decodable {
        let url: String

        enum CodingKeys: String, CodingKey {
            case url = "iframeUrl"
        }
    }

    struct URLWrapper: Decodable {
        let url: String
    }
}

struct WebViewMessage: Decodable {
    let id: String
    let type: `Type`

    enum `Type` {
        case isLoaded
        case updatePosition(value: CGPoint)
        case heightChange(value: CGFloat, firstPosition: Bool)
        case close
        case launchCalendar(url: String)
        case closeCalendar
        case openLink(url: String)
        case addCookie
        case unknown
    }

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case value
        case firstPosition = "fistPostHeight"
    }

    enum PositionKeys: CodingKey {
        case x
        case y
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        let type: String = try container.decode(String.self, forKey: .type)
        switch type {
        case MessageType.isLoaded:
            self.type = .isLoaded
        case MessageType.heightChange:
            let height: CGFloat = try container.decode(CGFloat.self, forKey: .value)
            let firstPosition: Bool = try container.decode(Bool.self, forKey: .firstPosition)
            self.type = .heightChange(value: height, firstPosition: firstPosition)
        case MessageType.updatePosition:
            let container = try container.nestedContainer(keyedBy: PositionKeys.self, forKey: .value)
            let x: CGFloat = try container.decode(CGFloat.self, forKey: .x)
            let y: CGFloat = try container.decode(CGFloat.self, forKey: .y)

            self.type = .updatePosition(value: CGPoint(x: x, y: y))
        case MessageType.close:
            self.type = .close
        case MessageType.closeCalendar:
            self.type = .closeCalendar
        case MessageType.addCookie:
            self.type = .addCookie
        case MessageType.openLink:
            let urlWrapper: URLWrapper = try container.decode(URLWrapper.self, forKey: .value)
            self.type = .openLink(url: urlWrapper.url)
        case MessageType.replaceURL:
            let urlWrapper: URLWrapper = try container.decode(URLWrapper.self, forKey: .value)
            self.type = .openLink(url: urlWrapper.url)
        case MessageType.launchCalendar:
            let calendar: Calendar = try container.decode(Calendar.self, forKey: .value)
            self.type = .launchCalendar(url: calendar.url)
        default:
            self.type = .unknown
        }
    }
}
