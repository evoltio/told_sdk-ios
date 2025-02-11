//
//  TrackEventResult.swift
//  Told
//
//  Created by Jérémy Magnier on 15/01/2025.
//

enum TrackEventResult {
    case triggerOn(surveyId: String, delay: Int?)
    case noTrigger
}
