import Toybox.Graphics;

class Icons {

    static function drawSteps(dc, x, y, diameter) {
        if (AssetSprites.drawCentered(dc, Rez.Drawables.IconSteps, x, y)) {
            return;
        }

        var soleWidth = (diameter * 0.012).toNumber();
        var soleHeight = (diameter * 0.025).toNumber();
        var toeRadius = (diameter * 0.006).toNumber();
        var gap = (diameter * 0.014).toNumber();
        var stride = (diameter * 0.007).toNumber();

        dc.setAntiAlias(true);
        dc.setColor(Theme.PRIMARY, Graphics.COLOR_TRANSPARENT);
        dc.fillRoundedRectangle(
            x - gap - (soleWidth / 2),
            y - (soleHeight / 2),
            soleWidth,
            soleHeight,
            soleWidth / 2
        );
        dc.fillCircle(x - gap, y - (soleHeight / 2) - toeRadius, toeRadius);
        dc.fillRoundedRectangle(
            x + gap - (soleWidth / 2),
            y - (soleHeight / 2) + stride,
            soleWidth,
            soleHeight,
            soleWidth / 2
        );
        dc.fillCircle(
            x + gap,
            y - (soleHeight / 2) - toeRadius + stride,
            toeRadius
        );
    }

    static function drawBattery(dc, x, y, diameter) {
        if (AssetSprites.drawCentered(dc, Rez.Drawables.IconBattery, x, y)) {
            return;
        }

        var width = (diameter * 0.052).toNumber();
        var height = (diameter * 0.027).toNumber();
        var terminalWidth = (diameter * 0.006).toNumber();
        var terminalHeight = (diameter * 0.012).toNumber();
        var padding = 3;

        dc.setAntiAlias(true);
        dc.setPenWidth(2);
        dc.setColor(Theme.PRIMARY, Graphics.COLOR_TRANSPARENT);
        dc.drawRoundedRectangle(
            x - (width / 2),
            y - (height / 2),
            width,
            height,
            2
        );
        dc.fillRectangle(
            x - (width / 2) + padding,
            y - (height / 2) + padding,
            width - (padding * 2),
            height - (padding * 2)
        );
        dc.fillRoundedRectangle(
            x + (width / 2) + 2,
            y - (terminalHeight / 2),
            terminalWidth,
            terminalHeight,
            1
        );
    }

    static function drawTemperature(dc, x, y, diameter) {
        if (AssetSprites.drawCentered(dc, Rez.Drawables.IconTemperature, x, y)) {
            return;
        }

        var bulbRadius = (diameter * 0.011).toNumber();
        var stemHeight = (diameter * 0.042).toNumber();
        var stemHalfWidth = (diameter * 0.007).toNumber();

        dc.setAntiAlias(true);
        dc.setColor(Theme.PRIMARY, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);
        dc.drawRoundedRectangle(
            x - stemHalfWidth,
            y - (stemHeight / 2),
            stemHalfWidth * 2,
            stemHeight,
            stemHalfWidth
        );
        dc.drawLine(x, y - (stemHeight / 2) + 5, x, y + 5);
        dc.fillCircle(x, y + (stemHeight / 2), bulbRadius);
    }

    static function drawHeart(dc, x, y, diameter) {
        if (AssetSprites.drawCentered(dc, Rez.Drawables.IconHeart, x, y)) {
            return;
        }

        var lobeRadius = (diameter * 0.010).toNumber();
        var halfWidth = (diameter * 0.019).toNumber();
        var bottom = y + (diameter * 0.024).toNumber();

        dc.setAntiAlias(true);
        dc.setColor(Theme.PRIMARY, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(x - lobeRadius, y, lobeRadius);
        dc.fillCircle(x + lobeRadius, y, lobeRadius);
        dc.fillPolygon([
            [x - halfWidth, y],
            [x + halfWidth, y],
            [x, bottom]
        ]);
    }

    static function drawBodyBattery(dc, x, y, diameter) {
        if (AssetSprites.drawCentered(dc, Rez.Drawables.IconBodyBattery, x, y)) {
            return;
        }

        var personX = x - (diameter * 0.010).toNumber();
        var headRadius = (diameter * 0.007).toNumber();
        var bodyTop = y + (diameter * 0.012).toNumber();
        var bodyBottom = y + (diameter * 0.041).toNumber();
        var arm = (diameter * 0.013).toNumber();

        dc.setAntiAlias(true);
        dc.setColor(Theme.PRIMARY, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);
        dc.drawCircle(personX, y, headRadius);
        dc.drawLine(personX, bodyTop, personX, bodyBottom);
        dc.drawLine(
            personX,
            bodyTop + 2,
            x - arm,
            bodyTop + (diameter * 0.013).toNumber()
        );
        dc.drawLine(
            personX,
            bodyTop + 2,
            x + 1,
            bodyTop + (diameter * 0.010).toNumber()
        );

        drawLightning(
            dc,
            x + (diameter * 0.014).toNumber(),
            y + (diameter * 0.023).toNumber(),
            diameter
        );
    }

    private static function drawLightning(dc, x, y, diameter) {
        var width = (diameter * 0.013).toNumber();
        var height = (diameter * 0.027).toNumber();

        dc.fillPolygon([
            [x + 1, y - height],
            [x - width, y + 1],
            [x - 1, y + 1],
            [x - 4, y + height],
            [x + width, y - 3],
            [x + 2, y - 3]
        ]);
    }
}
