//
//  Logger.swift
//  Told
//
//  Created by Jérémy Magnier on 27/01/2025.
//

/// The log level.
public enum LogLevel {
    /// Appropriate for informational messages.
    case info
    /// Appropriate for messages that contain information normally of use only when
    /// debugging a program.
    case debug
    /// Appropriate for error conditions.
    case error
}

/// A type that will handle the logs from the SDK
/// You can provide your own `LogHandler` implementation by passing it when initializing Told
public protocol LogHandler {
    /// Log a message passing the log level as a parameter.
    ///
    /// If the ``logLevel`` passed to this method is debug and Told is not initialized in debug mode, it will not be logged,
    ///
    /// - parameters:
    ///    - level: The log level to log `message` at. For the available log levels, see `LogLevel`.
    ///    - message: The message to be logged. `message`.
    func log(level: LogLevel, message: String)
}
