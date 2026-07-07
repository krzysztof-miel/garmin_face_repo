import Toybox.Graphics;
import Toybox.Math;

class Complications {
    private static const BATTERY_ARC_START = 135;
    private static const BATTERY_ARC_SWEEP = 270;
    private static const BATTERY_ARC_STEPS = 48;

    static function drawSteps(dc, centerX, centerY, diameter, font, value) {
        var x = FaceLayout.x(centerX, diameter, FaceLayout.STEPS_X);
        var y = FaceLayout.y(centerY, diameter, FaceLayout.STEPS_Y);
        var radius = (diameter * FaceLayout.COMPLICATION_RADIUS).toNumber();

        if (!AssetSprites.isModelOverlayActive()) {
            drawComplicationCircle(dc, x, y, radius);
            Icons.drawSteps(dc, x, y - (diameter * 0.038).toNumber(), diameter);
        }

        dc.setColor(Theme.TEXT, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            x,
            y + (diameter * 0.043).toNumber(),
            font,
            value,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    static function drawBattery(
        dc,
        centerX,
        centerY,
        diameter,
        font,
        value,
        percent
    ) {
        var x = FaceLayout.x(centerX, diameter, FaceLayout.BATTERY_X);
        var y = FaceLayout.y(centerY, diameter, FaceLayout.BATTERY_Y);
        var radius = diameter * FaceLayout.BATTERY_RADIUS;
        var ringWidth = (diameter * 0.017).toNumber();

        if (ringWidth < 5) {
            ringWidth = 5;
        }

        if (!AssetSprites.isModelOverlayActive()) {
            drawBatteryArc(
                dc,
                x,
                y,
                radius,
                ringWidth,
                BATTERY_ARC_START,
                BATTERY_ARC_START + BATTERY_ARC_SWEEP,
                Theme.RING_INACTIVE
            );
        }

        var clampedPercent = percent;
        if (clampedPercent < 0) {
            clampedPercent = 0;
        } else if (clampedPercent > 100) {
            clampedPercent = 100;
        }

        if (clampedPercent > 0 && !AssetSprites.isModelOverlayActive()) {
            drawBatteryArc(
                dc,
                x,
                y,
                radius,
                ringWidth,
                BATTERY_ARC_START,
                BATTERY_ARC_START
                    + (BATTERY_ARC_SWEEP * clampedPercent / 100.0),
                Theme.PRIMARY
            );
        }

        if (!AssetSprites.isModelOverlayActive()) {
            Icons.drawBattery(
                dc,
                x,
                y - (diameter * 0.030).toNumber(),
                diameter
            );
        }

        dc.setColor(Theme.TEXT, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            x,
            y + (diameter * 0.046).toNumber(),
            font,
            value,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    static function drawTemperature(
        dc,
        centerX,
        centerY,
        diameter,
        font,
        value
    ) {
        var x = FaceLayout.x(centerX, diameter, FaceLayout.TEMPERATURE_X);
        var y = FaceLayout.y(centerY, diameter, FaceLayout.TEMPERATURE_Y);
        var radius = (diameter * FaceLayout.COMPLICATION_RADIUS).toNumber();

        if (!AssetSprites.isModelOverlayActive()) {
            drawComplicationCircle(dc, x, y, radius);
            Icons.drawTemperature(
                dc,
                x,
                y - (diameter * 0.039).toNumber(),
                diameter
            );
        }

        dc.setColor(Theme.TEXT, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            x,
            y + (diameter * 0.043).toNumber(),
            font,
            value,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    static function drawHeartRate(
        dc,
        centerX,
        centerY,
        diameter,
        valueFont,
        labelFont,
        value
    ) {
        var x = FaceLayout.x(centerX, diameter, FaceLayout.HEART_RATE_X);
        var y = FaceLayout.y(centerY, diameter, FaceLayout.HEART_RATE_Y);
        var radius = (diameter * FaceLayout.COMPLICATION_RADIUS).toNumber();

        if (!AssetSprites.isModelOverlayActive()) {
            drawComplicationCircle(dc, x, y, radius);
            Icons.drawHeart(
                dc,
                x,
                y - (diameter * 0.045).toNumber(),
                diameter
            );
        }

        dc.setColor(Theme.TEXT, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            x,
            y + (diameter * 0.009).toNumber(),
            valueFont,
            value,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
        dc.setColor(Theme.TEXT_SECONDARY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            x,
            y + (diameter * 0.048).toNumber(),
            labelFont,
            "bpm",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    static function drawBodyBattery(
        dc,
        centerX,
        centerY,
        diameter,
        font,
        value
    ) {
        var x = FaceLayout.x(centerX, diameter, FaceLayout.BODY_BATTERY_X);
        var y = FaceLayout.y(centerY, diameter, FaceLayout.BODY_BATTERY_Y);
        var radius = (diameter * FaceLayout.COMPLICATION_RADIUS).toNumber();

        if (!AssetSprites.isModelOverlayActive()) {
            drawComplicationCircle(dc, x, y, radius);
            Icons.drawBodyBattery(
                dc,
                x,
                y - (diameter * 0.043).toNumber(),
                diameter
            );
        }

        dc.setColor(Theme.TEXT, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            x,
            y + (diameter * 0.029).toNumber(),
            font,
            value,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    static function drawDateCapsule(
        dc,
        centerX,
        centerY,
        diameter,
        font,
        value
    ) {
        var width = (diameter * FaceLayout.DATE_WIDTH).toNumber();
        var height = (diameter * FaceLayout.DATE_HEIGHT).toNumber();
        var capsuleCenterX = FaceLayout.x(
            centerX,
            diameter,
            FaceLayout.DATE_X
        );
        var capsuleCenterY = FaceLayout.y(
            centerY,
            diameter,
            FaceLayout.DATE_Y
        );
        var y = capsuleCenterY - (height / 2);

        if (
            !AssetSprites.isModelOverlayActive()
            && !AssetSprites.drawCentered(
                dc,
                Rez.Drawables.DecorDateCapsule,
                capsuleCenterX,
                capsuleCenterY
            )
        ) {
            var x = capsuleCenterX - (width / 2);
            var cornerRadius = height / 2;

            dc.setAntiAlias(true);
            dc.setColor(Theme.BACKGROUND, Theme.BACKGROUND);
            dc.fillRoundedRectangle(x, y, width, height, cornerRadius);

            dc.setPenWidth(1);
            dc.setColor(Theme.OUTLINE, Graphics.COLOR_TRANSPARENT);
            dc.drawRoundedRectangle(x, y, width, height, cornerRadius);
        }

        dc.setColor(Theme.TEXT, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            capsuleCenterX,
            y + (height / 2),
            font,
            value,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    private static function drawComplicationCircle(dc, x, y, radius) {
        if (!AssetSprites.drawCentered(dc, Rez.Drawables.DecorComplicationCircle, x, y)) {
            Drawing.drawCircleComplication(dc, x, y, radius);
        }
    }

    private static function drawBatteryArc(
        dc,
        centerX,
        centerY,
        radius,
        width,
        startDegrees,
        endDegrees,
        color
    ) {
        var steps = BATTERY_ARC_STEPS;
        var previousX = 0;
        var previousY = 0;

        dc.setAntiAlias(true);
        dc.setPenWidth(width);
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);

        for (var i = 0; i <= steps; i += 1) {
            var progress = i.toFloat() / steps;
            var degrees = startDegrees + ((endDegrees - startDegrees) * progress);
            var radians = degrees * Math.PI / 180.0;
            var x = centerX + (radius * Math.cos(radians)).toNumber();
            var y = centerY + (radius * Math.sin(radians)).toNumber();

            if (i > 0) {
                dc.drawLine(previousX, previousY, x, y);
            }

            previousX = x;
            previousY = y;
        }

        var capRadius = (width / 2).toNumber();
        var startRadians = startDegrees * Math.PI / 180.0;
        var endRadians = endDegrees * Math.PI / 180.0;
        dc.fillCircle(
            centerX + (radius * Math.cos(startRadians)).toNumber(),
            centerY + (radius * Math.sin(startRadians)).toNumber(),
            capRadius
        );
        dc.fillCircle(
            centerX + (radius * Math.cos(endRadians)).toNumber(),
            centerY + (radius * Math.sin(endRadians)).toNumber(),
            capRadius
        );
    }
}
