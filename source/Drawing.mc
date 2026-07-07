import Toybox.Graphics;

class Drawing {

    static function drawBackground(dc) {
        dc.setColor(Theme.BACKGROUND, Theme.BACKGROUND);
        dc.clear();
    }

    static function drawCircleComplication(dc, x, y, radius) {
        dc.setAntiAlias(true);
        dc.setPenWidth(1);
        dc.setColor(Theme.OUTLINE, Graphics.COLOR_TRANSPARENT);
        dc.drawCircle(x, y, radius);
    }

    static function drawCenteredText(dc, text, x, y, font, color) {
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            x,
            y,
            font,
            text,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }
}
