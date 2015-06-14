//
//  Zenophone.swift
//  Zenphones
//
//  Created by Joseph Blau on 6/13/15.
//  Copyright (c) 2015 Joe Blau. All rights reserved.
//

import AudioKit

// This is the microphone input and processor for the zenophones

class Zenophone: AKInstrument {

    let auxilliaryOutput = AKAudio.globalParameter()
    
    let lowPassCutoffFrequency = AKInstrumentProperty(value: 5000, minimum: 0, maximum: 20000)
    let highPassCutoffFrequency  = AKInstrumentProperty(value: 2000, minimum: 0, maximum: 20000)
    let invertInstrumentPhase = AKInstrumentProperty(value: 1.0)
    let delaySync = AKInstrumentProperty(value: 0, minimum: 0, maximum: 4.0)
    
    let stepDelaySync = AKInstrumentProperty(value: 0.0000000000000000000000000000000000000117549)
    
    override init() {
        super.init()
//        AKManager.sharedManager().isLogging = true
        
        let microphone = AKAudioInput()

//        // Low pass to filter out high frequences
//        let lpf = AKLowPassButterworthFilter(input: microphone, cutoffFrequency: lowPassCutoffFrequency)
//
//        // High pass to filter out low frequences
//        let hpf = AKHighPassButterworthFilter(input: lpf, cutoffFrequency: highPassCutoffFrequency)
        
        // Phase Inversion to cancel remaining frequences
        let im = microphone.scaledBy(invertInstrumentPhase)



        let del = AKVariableDelay(input: im)
        del.delayTime = stepDelaySync
//        AKVariableDelay(input: im, delayTime: delaySync, maximumDelayTime: <#AKConstant#>)
        
        
        
//        let del = AKDelay(input: im, delayTime: 0.005.ak, feedback: 0.0.ak)
//        let mix = AKMix(input1: microphone, input2: im, balance: (0.5).ak)
        
//        enableParameterLog("Micropho: ", parameter: hpf, timeInterval: 1)
//        enableParameterLog("Inverted: ", parameter: im, timeInterval: 1)

        appendOutput(auxilliaryOutput, withInput: del)
//        setAudioOutput(del)

    }
}
