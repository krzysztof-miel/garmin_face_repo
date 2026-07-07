import Toybox.Graphics;
import Toybox.WatchUi;

class RoundedTimeFont {
    private static const DIGIT_WIDTH = 68;
    private static const GLYPH_HEIGHT = 120;
    private static const STROKE = 18;
    private static const GAP = 8;
    private static const COLON_WIDTH = 24;

    static function draw(dc, value, centerX, centerY, diameter) {
        if (drawBitmapTime(dc, value, centerX, centerY)) {
            return;
        }

        var scale = diameter * 0.00255;
        var width = measure(value, scale);
        var x = centerX - (width / 2);
        var y = centerY - ((GLYPH_HEIGHT * scale) / 2);
        var index = 0;

        dc.setAntiAlias(true);
        dc.setColor(Theme.DIM, Graphics.COLOR_TRANSPARENT);
        drawAt(dc, value, x - 1, y, scale);
        drawAt(dc, value, x + 1, y, scale);

        dc.setColor(Theme.TEXT, Graphics.COLOR_TRANSPARENT);
        drawAt(dc, value, x, y, scale);
    }

    private static function drawBitmapTime(dc, value, centerX, centerY) {
        try {
            var width = measureBitmap(value);
            if (width <= 0) {
                return false;
            }

            var cursor = centerX - (width / 2);
            var middleY = centerY.toNumber();

            for (var i = 0; i < value.length(); i += 1) {
                var bitmap = loadBitmap(value.substring(i, i + 1));
                if (bitmap == null) {
                    return false;
                }

                dc.drawBitmap(
                    cursor,
                    middleY - (bitmap.getHeight() / 2),
                    bitmap
                );
                cursor += bitmap.getWidth() + bitmapGap();
            }

            return true;
        } catch (ex) {
        }

        return false;
    }

    private static function measureBitmap(value) {
        var width = 0;

        for (var i = 0; i < value.length(); i += 1) {
            var bitmap = loadBitmap(value.substring(i, i + 1));
            if (bitmap == null) {
                return 0;
            }

            width += bitmap.getWidth();
            if (i < value.length() - 1) {
                width += bitmapGap();
            }
        }

        return width;
    }

    private static function bitmapGap() {
        return 9;
    }

    private static function loadBitmap(character) {
        if (character.equals("0")) {
            return WatchUi.loadResource(Rez.Drawables.TimeDigit0);
        } else if (character.equals("1")) {
            return WatchUi.loadResource(Rez.Drawables.TimeDigit1);
        } else if (character.equals("2")) {
            return WatchUi.loadResource(Rez.Drawables.TimeDigit2);
        } else if (character.equals("3")) {
            return WatchUi.loadResource(Rez.Drawables.TimeDigit3);
        } else if (character.equals("4")) {
            return WatchUi.loadResource(Rez.Drawables.TimeDigit4);
        } else if (character.equals("5")) {
            return WatchUi.loadResource(Rez.Drawables.TimeDigit5);
        } else if (character.equals("6")) {
            return WatchUi.loadResource(Rez.Drawables.TimeDigit6);
        } else if (character.equals("7")) {
            return WatchUi.loadResource(Rez.Drawables.TimeDigit7);
        } else if (character.equals("8")) {
            return WatchUi.loadResource(Rez.Drawables.TimeDigit8);
        } else if (character.equals("9")) {
            return WatchUi.loadResource(Rez.Drawables.TimeDigit9);
        } else if (character.equals(":")) {
            return WatchUi.loadResource(Rez.Drawables.TimeColon);
        }

        return null;
    }

    private static function drawAt(dc, value, x, y, scale) {
        var cursor = x;

        for (var i = 0; i < value.length(); i += 1) {
            var character = value.substring(i, i + 1);

            if (character.equals(":")) {
                drawColon(dc, cursor, y, scale);
                cursor += (COLON_WIDTH + GAP) * scale;
            } else {
                drawDigit(dc, character, cursor, y, scale);
                cursor += (DIGIT_WIDTH + GAP) * scale;
            }
        }
    }

    private static function measure(value, scale) {
        var width = 0;

        for (var i = 0; i < value.length(); i += 1) {
            var character = value.substring(i, i + 1);
            width += character.equals(":") ? COLON_WIDTH : DIGIT_WIDTH;

            if (i < value.length() - 1) {
                width += GAP;
            }
        }

        return width * scale;
    }

    private static function drawDigit(dc, digit, x, y, scale) {
        if (digit.equals("0")) {
            top(dc, x, y, scale);
            upperLeft(dc, x, y, scale);
            upperRight(dc, x, y, scale);
            lowerLeft(dc, x, y, scale);
            lowerRight(dc, x, y, scale);
            bottom(dc, x, y, scale);
        } else if (digit.equals("1")) {
            oneStem(dc, x, y, scale);
        } else if (digit.equals("2")) {
            top(dc, x, y, scale);
            upperRight(dc, x, y, scale);
            middle(dc, x, y, scale);
            lowerLeft(dc, x, y, scale);
            bottom(dc, x, y, scale);
        } else if (digit.equals("3")) {
            top(dc, x, y, scale);
            upperRight(dc, x, y, scale);
            middle(dc, x, y, scale);
            lowerRight(dc, x, y, scale);
            bottom(dc, x, y, scale);
        } else if (digit.equals("4")) {
            upperLeft(dc, x, y, scale);
            upperRight(dc, x, y, scale);
            middle(dc, x, y, scale);
            lowerRight(dc, x, y, scale);
        } else if (digit.equals("5")) {
            top(dc, x, y, scale);
            upperLeft(dc, x, y, scale);
            middle(dc, x, y, scale);
            lowerRight(dc, x, y, scale);
            bottom(dc, x, y, scale);
        } else if (digit.equals("6")) {
            top(dc, x, y, scale);
            upperLeft(dc, x, y, scale);
            middle(dc, x, y, scale);
            lowerLeft(dc, x, y, scale);
            lowerRight(dc, x, y, scale);
            bottom(dc, x, y, scale);
        } else if (digit.equals("7")) {
            top(dc, x, y, scale);
            upperRight(dc, x, y, scale);
            lowerRight(dc, x, y, scale);
        } else if (digit.equals("8")) {
            top(dc, x, y, scale);
            upperLeft(dc, x, y, scale);
            upperRight(dc, x, y, scale);
            middle(dc, x, y, scale);
            lowerLeft(dc, x, y, scale);
            lowerRight(dc, x, y, scale);
            bottom(dc, x, y, scale);
        } else if (digit.equals("9")) {
            top(dc, x, y, scale);
            upperLeft(dc, x, y, scale);
            upperRight(dc, x, y, scale);
            middle(dc, x, y, scale);
            lowerRight(dc, x, y, scale);
            bottom(dc, x, y, scale);
        }
    }

    private static function drawColon(dc, x, y, scale) {
        var radius = (STROKE * 0.43 * scale).toNumber();
        var centerX = (x + (COLON_WIDTH * scale / 2)).toNumber();

        dc.fillCircle(
            centerX,
            (y + (GLYPH_HEIGHT * 0.35 * scale)).toNumber(),
            radius
        );
        dc.fillCircle(
            centerX,
            (y + (GLYPH_HEIGHT * 0.67 * scale)).toNumber(),
            radius
        );
    }

    private static function oneStem(dc, x, y, scale) {
        roundRect(
            dc,
            x + (DIGIT_WIDTH * 0.42 * scale),
            y,
            STROKE * scale,
            GLYPH_HEIGHT * scale,
            scale
        );
        roundRect(
            dc,
            x + (DIGIT_WIDTH * 0.22 * scale),
            y + (GLYPH_HEIGHT * 0.02 * scale),
            DIGIT_WIDTH * 0.30 * scale,
            STROKE * scale,
            scale
        );
    }

    private static function top(dc, x, y, scale) {
        horizontal(dc, x, y, 0, scale);
    }

    private static function middle(dc, x, y, scale) {
        horizontal(dc, x, y, 51, scale);
    }

    private static function bottom(dc, x, y, scale) {
        horizontal(dc, x, y, 102, scale);
    }

    private static function upperLeft(dc, x, y, scale) {
        vertical(dc, x, y, 8, scale);
    }

    private static function upperRight(dc, x, y, scale) {
        vertical(dc, x + ((DIGIT_WIDTH - STROKE) * scale), y, 8, scale);
    }

    private static function lowerLeft(dc, x, y, scale) {
        vertical(dc, x, y, 58, scale);
    }

    private static function lowerRight(dc, x, y, scale) {
        vertical(dc, x + ((DIGIT_WIDTH - STROKE) * scale), y, 58, scale);
    }

    private static function horizontal(dc, x, y, offsetY, scale) {
        roundRect(
            dc,
            x + ((STROKE / 2) * scale),
            y + (offsetY * scale),
            (DIGIT_WIDTH - STROKE) * scale,
            STROKE * scale,
            scale
        );
    }

    private static function vertical(dc, x, y, offsetY, scale) {
        roundRect(
            dc,
            x,
            y + (offsetY * scale),
            STROKE * scale,
            48 * scale,
            scale
        );
    }

    private static function roundRect(dc, x, y, width, height, scale) {
        var radius = ((STROKE / 2) * scale).toNumber();
        dc.fillRoundedRectangle(
            x.toNumber(),
            y.toNumber(),
            width.toNumber(),
            height.toNumber(),
            radius
        );
    }
}
