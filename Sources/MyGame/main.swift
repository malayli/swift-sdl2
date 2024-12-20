import Foundation
import CSDL2
import CSDL2_ttf

// Initialize the SDL library
guard SDL_Init(SDL_INIT_VIDEO) == 0 else {
    fatalError("SDL could not initialize! SDL_Error: \(String(cString: SDL_GetError()))")
}

// Initialize the SDL_ttf library
guard TTF_Init() == 0 else {
    fatalError("TTF could not initialize!")
}

// Get the font path
let fontPath = getFontPath()
print("Using font path: \(fontPath)")

// Load the font
guard let font = TTF_OpenFont(fontPath, 24) else {
    fatalError("Could not load font! SDL_ttf Error")
}

// Create the SDL window
let window = SDL_CreateWindow(
    "BeyondU21",
    Int32(SDL_WINDOWPOS_CENTERED_MASK), Int32(SDL_WINDOWPOS_CENTERED_MASK),
    800, 600,
    UInt32(SDL_WINDOW_SHOWN.rawValue)
)

// Create the renderer
guard let renderer = SDL_CreateRenderer(
    window, -1,
    UInt32(SDL_RENDERER_ACCELERATED.rawValue)
) else {
    fatalError("Renderer could not be created!")
}

let text = "Digital Fox presents"
var context = GameStateHandler()
var event = SDL_Event()

// Display an initial black screen
SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255)
SDL_RenderClear(renderer)
SDL_RenderPresent(renderer)

// Game loop
var running = true
while running {
    // Event handling
    while SDL_PollEvent(&event) > 0 {
        if event.type == SDL_QUIT.rawValue {
            running = false
        }
    }

    context.update()
    context.render(renderer: renderer, font: font, text: text)
    SDL_RenderPresent(renderer)
    SDL_Delay(ConfigurationConstants.frameDelay)
}

// Cleanup
TTF_CloseFont(font)
TTF_Quit()
SDL_DestroyRenderer(renderer)
SDL_DestroyWindow(window)
SDL_Quit()
