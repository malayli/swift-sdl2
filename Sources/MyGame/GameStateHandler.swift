import CSDL2
import CSDL2_ttf

/// The game state handler.
struct GameStateHandler {
    var state: GameState = .fadeIn
    var opacity: UInt8 = 0
    var displayTimer: UInt32 = 0

    mutating func update() {
        switch state {
        case .fadeIn:
            if opacity < 255 {
                opacity += ConfigurationConstants.fadeSpeed
            } else {
                state = .display
                displayTimer = SDL_GetTicks()
            }

        case .display:
            if SDL_GetTicks() - displayTimer >= ConfigurationConstants.displayTime {
                state = .fadeOut
            }

        case .fadeOut:
            if opacity > 0 {
                opacity -= ConfigurationConstants.fadeSpeed
            } else {
                opacity = 0
                state = .home
            }

        case .home:
            opacity = 0
        }
    }

    func render(renderer: OpaquePointer?, font: OpaquePointer?, text: String) {
        // Clear the screen first
        SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255)
        SDL_RenderClear(renderer)

        // Only render text if we're not in home state AND opacity > 0
        if state != .home && opacity > 0 {
            let color = SDL_Color(r: 255, g: 255, b: 255, a: opacity)
            guard let surface = TTF_RenderText_Blended(font, text, color) else {
                fatalError("Could not create text surface!")
            }
            guard let texture = SDL_CreateTextureFromSurface(renderer, surface) else {
                fatalError("Could not create texture!")
            }

            var textWidth: Int32 = 0
            var textHeight: Int32 = 0
            SDL_QueryTexture(texture, nil, nil, &textWidth, &textHeight)

            var destRect = SDL_Rect(
                x: (800 - textWidth) / 2,
                y: (600 - textHeight) / 2,
                w: textWidth,
                h: textHeight
            )
            SDL_RenderCopy(renderer, texture, nil, &destRect)

            SDL_DestroyTexture(texture)
            SDL_FreeSurface(surface)
        }
    }
}
