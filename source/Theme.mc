import Toybox.Graphics;

class Theme {
    // Neutral monochrome palette. Every RGB channel has the same value,
    // which prevents blue, violet, or other color casts.
    static const BACKGROUND = 0x000000;
    static const PRIMARY = 0xF2F2F2;
    static const DIM = 0x383838;
    static const RING = 0xC8C8C8;
    static const TEXT = 0xEEEEEE;

    // Semantic aliases used by individual watch-face components.
    static const TEXT_SECONDARY = 0xC4C4C4;
    static const OUTLINE = RING;
    static const OUTLINE_SECONDARY = 0x686868;
    static const RING_INACTIVE = 0x2C2C2C;

    static function drawGlowText(dc, x, y, font, value, justification) {
        // A one-pixel shadow in two directions creates a restrained halo
        // without alpha blending, blur, or expensive off-screen buffers.
        dc.setColor(DIM, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x - 1, y, font, value, justification);
        dc.drawText(x + 1, y, font, value, justification);

        dc.setColor(TEXT, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, font, value, justification);
    }
}
