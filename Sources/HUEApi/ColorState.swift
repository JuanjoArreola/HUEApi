//
//  ColorState.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/27/19.
//

import Foundation

public class ColorState: Decodable {
    
    /// On/Off state of the light.
    public var on: Bool
    
    /// Brightness of the light.
    /// This is a scale from the minimum brightness the light is capable of, 1, to the maximum capable brightness, 254
    public var brightness: UInt8
    
    /// Hue of the light.
    ///This is a wrapping value between 0 and 65535.
    /// Note, that hue/sat values are hardware dependent which means that programming two devices with the same value does not garantuee that they will be the same color.
    /// Programming 0 and 65535 would mean that the light will resemble the color red, 21845 for green and 43690 for blue.
    public var hue: Int
    
    /// Saturation of the light.
    /// 254 is the most saturated (colored) and 0 is the least saturated (white).
    public var saturation: Int
    
    /// The x and y coordinates of a color in CIE color space.
    /// The first entry is the x coordinate and the second entry is the y coordinate. Both x and y are between 0 and 1.
    /// Using CIE xy, the colors can be the same on all lamps if the coordinates are within every lamps gamuts (example: “xy”:[0.409,0.5179] is the same color on all lamps).
    /// If not, the lamp will calculate it’s closest color and use that.
    /// The CIE xy color is absolute, independent from the hardware.
    public var xy: [Float]
    
    /// The Mired Color temperature of the light.
    /// 2012 connected lights are capable of 153 (6500K) to 500 (2000K).
    public var colorTemperature: UInt16
    
    /// The alert effect, which is a temporary change to the bulb’s state
    /// Note that this contains the last alert sent to the light and not its current state.
    /// i.e. After the breathe cycle has finished the bridge does not reset the alert to “none“.
    public var alert: LightAlert
    
    /// The dynamic effect of the light
    public var effect: LightEffect
    
    /// Indicates the color mode in which the light is working, this is the last command type it received.
    /// This parameter is only present when the light supports at least one of the values.
    public var colorMode: ColorMode?
    
    enum CodingKeys: String, CodingKey {
        case on, hue, xy, alert, effect
        case brightness = "bri"
        case saturation = "sat"
        case colorTemperature = "ct"
        case colorMode = "colormode"
    }
}

public enum LightAlert: String, Codable {
    /// The light is not performing an alert
    case none
    
    /// The light is performing one breathe cycle.
    case select
    
    /// The light is performing breathe cycles for 15 seconds or until an "alert": "none" command is received
    case longSelect = "lselect"
}

public enum LightEffect: String, Codable {
    /// The light is not performing an effect
    case none
    
    /// The light will cycle through all hues using the current brightness and saturation settings
    case colorLoop = "colorloop"
}

public enum ColorMode: String, Codable {
    case hue = "hs"
    case xy
    case colorTemperature = "ct"
}
