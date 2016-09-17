//
//  Zenophone.swift
//  Zenphones
//
//  Created by Joseph Blau on 6/13/15.
//  Copyright (c) 2015 Joe Blau. All rights reserved.
//

import AudioKit

// This is the microphone input and processor for Zenophones
class Zenophone: AKInstrument {

    private let auxilliaryOutput = AKAudio.global()
    private let delaySync = AKInstrumentProperty(value: 0, minimum: 0, maximum: 4.0)

    let lowPassCutoffFrequency = AKInstrumentProperty(value: 6000, minimum: 0, maximum: 20000)
    let highPassCutoffFrequency  = AKInstrumentProperty(value: 20, minimum: 0, maximum: 20000)
    let invertInstrumentPhase = AKInstrumentProperty(value: 1.0)
    
    override init() {
        super.init()        
        let microphone = AKAudioInput()

        // Low pass to filter out high frequences
        let lpf = AKLowPassButterworthFilter(input: microphone, cutoffFrequency: lowPassCutoffFrequency)

        // High pass to filter out low frequences
        let hpf = AKHighPassButterworthFilter(input: lpf, cutoffFrequency: highPassCutoffFrequency)
        
        // Phase Inversion to cancel remaining frequences
        let im = hpf.scaled(by: invertInstrumentPhase)

        setAudioOutput(im)
    }
}
