/**
 * Copyright (c) 2018 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import MetalKit

public struct Particle {
  public var position: float2
  public var velocity: float2
}

public struct Emitter {
  public var particleBuffer: MTLBuffer!
  
  public init(particleCount: Int, size: CGSize, device: MTLDevice) {
    let bufferSize = MemoryLayout<Particle>.stride * particleCount
    particleBuffer = device.makeBuffer(length: bufferSize)
    var pointer = particleBuffer.contents().bindMemory(to: Particle.self,
                                                       capacity: particleCount)
    for _ in 0..<particleCount {
      let width = random(Int(size.width) / 2) + Float(size.width) / Float(4)
      let height = random(Int(size.height) / 2) + Float(size.height) / Float(4)
      let position = float2(width, height)
      pointer.pointee.position = position
      let velocity = float2(random(10), random(10))
      pointer.pointee.velocity = velocity
      pointer = pointer.advanced(by: 1)
    }
  }
  
  func random(_ max: Int) -> Float {
    return Float.random(in: 0..<Float(max))
  }
}
