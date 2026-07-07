import Toybox.Graphics;
import Toybox.Math;

class Decorations {
    private static const ARC_STEPS = 18;

    static function draw(dc, centerX, centerY, diameter) {
        if (AssetSprites.drawModelOverlay(dc, centerX, centerY)) {
            return;
        }

        drawOuterRing(dc, centerX, centerY, diameter);
        drawDecorativeArcs(dc, centerX, centerY, diameter);
        drawDateGuideLines(dc, centerX, centerY, diameter);
    }

    static function drawOuterRing(dc, centerX, centerY, diameter) {
        var outerRadius = (diameter * 0.497).toNumber();
        var innerRadius = (diameter * 0.486).toNumber();

        dc.setAntiAlias(true);
        dc.setPenWidth(1);
        dc.setColor(Theme.OUTLINE_SECONDARY, Graphics.COLOR_TRANSPARENT);
        dc.drawCircle(centerX, centerY, outerRadius);
        dc.setColor(Theme.RING_INACTIVE, Graphics.COLOR_TRANSPARENT);
        dc.drawCircle(centerX, centerY, innerRadius);
    }

    static function drawDecorativeArcs(dc, centerX, centerY, diameter) {
        var sideRadius = diameter * 0.405;
        var topRadius = diameter * 0.414;
        var dotRadius = getDotRadius(diameter);

        dc.setAntiAlias(true);
        dc.setPenWidth(1);
        dc.setColor(Theme.OUTLINE, Graphics.COLOR_TRANSPARENT);

        drawArcSegment(dc, centerX, centerY, topRadius, -120, -92);
        drawArcSegment(dc, centerX, centerY, topRadius, -88, -60);
        drawDotAtAngle(dc, centerX, centerY, topRadius, -120, dotRadius);
        drawDotAtAngle(dc, centerX, centerY, topRadius, -60, dotRadius);

        dc.drawLine(
            centerX,
            centerY - (diameter * 0.438).toNumber(),
            centerX,
            centerY - (diameter * 0.416).toNumber()
        );

        drawArcSegment(dc, centerX, centerY, sideRadius, -165, -198);
        drawArcSegment(dc, centerX, centerY, sideRadius, -15, 18);
        drawDotAtAngle(dc, centerX, centerY, sideRadius, -165, dotRadius);
        drawDotAtAngle(dc, centerX, centerY, sideRadius, -198, dotRadius);
        drawDotAtAngle(dc, centerX, centerY, sideRadius, -15, dotRadius);
        drawDotAtAngle(dc, centerX, centerY, sideRadius, 18, dotRadius);
    }

    static function drawDateGuideLines(dc, centerX, centerY, diameter) {
        var dotRadius = getDotRadius(diameter);
        var y = centerY + (diameter * 0.374).toNumber();
        var leftOuter = centerX - (diameter * 0.187).toNumber();
        var leftInner = centerX - (diameter * 0.102).toNumber();
        var rightInner = centerX + (diameter * 0.100).toNumber();
        var rightOuter = centerX + (diameter * 0.183).toNumber();

        dc.drawLine(leftOuter, y, leftInner, y);
        dc.drawLine(rightInner, y, rightOuter, y);
        dc.fillCircle(leftOuter, y, dotRadius);
        dc.fillCircle(rightOuter, y, dotRadius);
    }

    private static function getDotRadius(diameter) {
        var radius = (diameter * 0.0045).toNumber();
        return radius < 2 ? 2 : radius;
    }

    private static function drawArcSegment(
        dc,
        centerX,
        centerY,
        radius,
        startDegrees,
        endDegrees
    ) {
        var previousX = 0;
        var previousY = 0;

        for (var i = 0; i <= ARC_STEPS; i += 1) {
            var progress = i.toFloat() / ARC_STEPS;
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
    }

    private static function drawDotAtAngle(
        dc,
        centerX,
        centerY,
        radius,
        degrees,
        dotRadius
    ) {
        var radians = degrees * Math.PI / 180.0;
        var x = centerX + (radius * Math.cos(radians)).toNumber();
        var y = centerY + (radius * Math.sin(radians)).toNumber();
        dc.fillCircle(x, y, dotRadius);
    }
}
