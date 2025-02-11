//
//  Logger.swift
//  Told
//
//  Created by Jérémy Magnier on 16/01/2025.
//

import OSLog

// The logger implementation that contains the log handler
final class Logger {
    // TODO: Maybe use severity instead
    private let debug: Bool
    private let handler: any LogHandler

    init(
        handler: any LogHandler,
        debug: Bool
    ) {
        self.handler = handler
        self.debug = debug
    }

    func log(level: LogLevel, message: String) {
        guard level != .debug || debug else { return }
        handler.log(level: level, message: message)
    }
}

// Default log handler for Told SDK
struct DefaultLogHandler: LogHandler  {
    private let logger: os.Logger = .init(subsystem: "club.told.app.widget", category: "main")

    func log(level: LogLevel, message: String) {
        switch level {
        case .debug:
            logger.log(level: .debug, "\(message)")
        case .error:
            logger.log(level: .error, "\(message)")
        case .info:
            logger.log(level: .info, "\(message)")
        }
    }
}
