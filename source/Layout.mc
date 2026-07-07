class FaceLayout {
    // Positions are normalized against min(width, height), with (0, 0) at
    // the center of the display. They come from LAYOUT_ANALYSIS.md.
    static const TIME_Y = 0.008;

    static const STEPS_X = -0.204;
    static const STEPS_Y = -0.262;
    static const BATTERY_X = 0.000;
    static const BATTERY_Y = -0.286;
    static const TEMPERATURE_X = 0.203;
    static const TEMPERATURE_Y = -0.262;

    static const HEART_RATE_X = -0.139;
    static const HEART_RATE_Y = 0.245;
    static const BODY_BATTERY_X = 0.127;
    static const BODY_BATTERY_Y = 0.245;

    static const DATE_X = 0.000;
    static const DATE_Y = 0.377;

    static const COMPLICATION_RADIUS = 0.090;
    static const BATTERY_RADIUS = 0.096;
    static const DATE_WIDTH = 0.202;
    static const DATE_HEIGHT = 0.060;

    static const TIME_FONT_SIZE = 0.285;
    static const COMPLICATION_FONT_SIZE = 0.058;
    static const LABEL_FONT_SIZE = 0.034;
    static const DATE_FONT_SIZE = 0.045;

    static function diameter(dc) {
        return dc.getWidth() < dc.getHeight()
            ? dc.getWidth()
            : dc.getHeight();
    }

    static function x(centerX, diameter, normalizedOffset) {
        return centerX + (diameter * normalizedOffset).toNumber();
    }

    static function y(centerY, diameter, normalizedOffset) {
        return centerY + (diameter * normalizedOffset).toNumber();
    }
}
