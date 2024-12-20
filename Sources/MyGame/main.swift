import Foundation
import CSDL2

enum WindowConfig {
    static let windowName = "MyGameName"
    static let width: Int32 = 800
    static let height: Int32 = 600
}

enum FrameConfig {
    static let delay: UInt32 = 16
}

// Initialize the SDL
guard SDL_Init(SDL_INIT_VIDEO) == 0 else {
    fatalError("SDL could not initialize! SDL_Error: \(String(cString: SDL_GetError()))")
}

// Create the window
let window = SDL_CreateWindow(WindowConfig.windowName,
                              Int32(SDL_WINDOWPOS_CENTERED_MASK),
                              Int32(SDL_WINDOWPOS_CENTERED_MASK),
                              WindowConfig.width,
                              WindowConfig.height,
                              UInt32(SDL_WINDOW_SHOWN.rawValue)
)

// Create a renderer
guard let renderer = SDL_CreateRenderer(window, -1,UInt32(SDL_RENDERER_ACCELERATED.rawValue)) else {
    fatalError("Renderer could not be created!")
}

// Display a black screen by default
SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255)
SDL_RenderClear(renderer)
SDL_RenderPresent(renderer)

// Game loop
var event = SDL_Event()
var running = true

while running {
    // Event handling
    while SDL_PollEvent(&event) > 0 {
        if event.type == SDL_QUIT.rawValue {
            running = false
        }
    }

    SDL_RenderPresent(renderer)
    SDL_Delay(FrameConfig.delay)
}

// Cleanup
SDL_DestroyRenderer(renderer)
SDL_DestroyWindow(window)
SDL_Quit()
