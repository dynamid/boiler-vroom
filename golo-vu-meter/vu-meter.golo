module Rpi

import com.pi4j.io.gpio
import com.pi4j.io.gpio.event

function main = |args| {
  
  let gpio = GpioFactory.getInstance()
  let leds = [
    gpio: provisionDigitalOutputPin(RaspiPin.GPIO_00()),
    gpio: provisionDigitalOutputPin(RaspiPin.GPIO_01()),
    gpio: provisionDigitalOutputPin(RaspiPin.GPIO_02()),
    gpio: provisionDigitalOutputPin(RaspiPin.GPIO_03()),
    gpio: provisionDigitalOutputPin(RaspiPin.GPIO_04()),
    gpio: provisionDigitalOutputPin(RaspiPin.GPIO_05()),
    gpio: provisionDigitalOutputPin(RaspiPin.GPIO_06()),
    gpio: provisionDigitalOutputPin(RaspiPin.GPIO_07())
  ]

  let handleLED = |pin, threshold, level| {
    if level > threshold {
      pin: high()
    } else {
      pin: low()
    }
  }
  
  let topic = Distributed.topic("vu-meter")
  topic: addMessageListener(|message| {
    let level = message: getMessageObject()
    handleLED(leds: get(0), 42, level)
    handleLED(leds: get(1), 56, level)
    handleLED(leds: get(2), 70, level)
    handleLED(leds: get(3), 90, level)
    handleLED(leds: get(4), 100, level)
    handleLED(leds: get(5), 112, level)
    handleLED(leds: get(6), 118, level)
    handleLED(leds: get(7), 122, level)
  })
}
