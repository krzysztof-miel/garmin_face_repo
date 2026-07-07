import Toybox.Graphics;
import Toybox.WatchUi;

class WatchFaceView extends WatchUi.WatchFace {
    private var _timeFont = Graphics.FONT_LARGE;
    private var _complicationFont = Graphics.FONT_SMALL;
    private var _labelFont = Graphics.FONT_XTINY;
    private var _dateFont = Graphics.FONT_SMALL;
    private var _isLowPower = false;

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void {
        var diameter = FaceLayout.diameter(dc);
        var fontSize = (diameter * FaceLayout.TIME_FONT_SIZE).toNumber();
        var vectorFont = Graphics.getVectorFont({
            :face => "RobotoBold",
            :size => fontSize
        });

        // Use a rounder system vector font for the large clock digits.
        // Keep a non-numeric built-in font as a less angular fallback.
        if (vectorFont != null) {
            _timeFont = vectorFont;
        }

        var complicationFont = Graphics.getVectorFont({
            :face => "RobotoCondensedRegular",
            :size => (diameter * FaceLayout.COMPLICATION_FONT_SIZE).toNumber()
        });
        if (complicationFont != null) {
            _complicationFont = complicationFont;
        }

        var labelFont = Graphics.getVectorFont({
            :face => "RobotoCondensedRegular",
            :size => (diameter * FaceLayout.LABEL_FONT_SIZE).toNumber()
        });
        if (labelFont != null) {
            _labelFont = labelFont;
        }

        var dateFont = Graphics.getVectorFont({
            :face => "RobotoCondensedRegular",
            :size => (diameter * FaceLayout.DATE_FONT_SIZE).toNumber()
        });
        if (dateFont != null) {
            _dateFont = dateFont;
        }
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;
        var diameter = FaceLayout.diameter(dc);
        var timeText = DataProvider.getTimeLabel();
        var dateText = DataProvider.getDateLabel();
        var batteryPercent = DataProvider.getBatteryPercent();
        var batteryProgress = batteryPercent == null ? 0 : batteryPercent;
        var batteryText = batteryPercent == null
            ? DataProvider.PLACEHOLDER
            : batteryPercent.format("%d") + "%";

        if (_isLowPower) {
            drawLowPower(
                dc,
                centerX,
                centerY,
                diameter,
                timeText,
                dateText,
                batteryText,
                batteryProgress
            );
            return;
        }

        // Activity, weather, and sensor-history queries are intentionally
        // skipped in low-power mode and refreshed only while active.
        var stepsText = DataProvider.getSteps();
        var temperatureText = DataProvider.getTemperature();
        var heartRateText = DataProvider.getHeartRate();
        var bodyBatteryText = DataProvider.getBodyBattery();

        drawBackground(dc);
        Decorations.draw(dc, centerX, centerY, diameter);
        drawTopComplications(
            dc,
            centerX,
            centerY,
            diameter,
            stepsText,
            batteryText,
            batteryProgress,
            temperatureText
        );
        drawBottomComplications(
            dc,
            centerX,
            centerY,
            diameter,
            heartRateText,
            bodyBatteryText
        );
        drawDateCapsule(dc, centerX, centerY, diameter, dateText);
        drawTime(dc, centerX, centerY, diameter, timeText);
    }

    private function drawLowPower(
        dc,
        centerX,
        centerY,
        diameter,
        time,
        date,
        battery,
        batteryPercent
    ) {
        Drawing.drawBackground(dc);
        Complications.drawBattery(
            dc,
            centerX,
            centerY,
            diameter,
            _complicationFont,
            battery,
            batteryPercent
        );
        Complications.drawDateCapsule(
            dc,
            centerX,
            centerY,
            diameter,
            _dateFont,
            date
        );
        RoundedTimeFont.draw(
            dc,
            time,
            centerX,
            FaceLayout.y(centerY, diameter, FaceLayout.TIME_Y),
            diameter
        );
    }

    private function drawBackground(dc) {
        Drawing.drawBackground(dc);
    }

    private function drawTime(dc, centerX, centerY, diameter, value) {
        RoundedTimeFont.draw(
            dc,
            value,
            centerX,
            FaceLayout.y(centerY, diameter, FaceLayout.TIME_Y),
            diameter
        );
    }

    private function drawTopComplications(
        dc,
        centerX,
        centerY,
        diameter,
        steps,
        battery,
        batteryPercent,
        temperature
    ) {
        Complications.drawSteps(
            dc,
            centerX,
            centerY,
            diameter,
            _complicationFont,
            steps
        );
        Complications.drawBattery(
            dc,
            centerX,
            centerY,
            diameter,
            _complicationFont,
            battery,
            batteryPercent
        );
        Complications.drawTemperature(
            dc,
            centerX,
            centerY,
            diameter,
            _complicationFont,
            temperature
        );
    }

    private function drawBottomComplications(
        dc,
        centerX,
        centerY,
        diameter,
        heartRate,
        bodyBattery
    ) {
        Complications.drawHeartRate(
            dc,
            centerX,
            centerY,
            diameter,
            _complicationFont,
            _labelFont,
            heartRate
        );
        Complications.drawBodyBattery(
            dc,
            centerX,
            centerY,
            diameter,
            _complicationFont,
            bodyBattery
        );
    }

    private function drawDateCapsule(
        dc,
        centerX,
        centerY,
        diameter,
        date
    ) {
        Complications.drawDateCapsule(
            dc,
            centerX,
            centerY,
            diameter,
            _dateFont,
            date
        );
    }

    function onHide() as Void {
    }

    function onExitSleep() as Void {
        _isLowPower = false;
        WatchUi.requestUpdate();
    }

    function onEnterSleep() as Void {
        _isLowPower = true;
    }

    // The face does not display seconds, so no per-second partial update is
    // needed. onUpdate() refreshes the low-power face once per minute.
    function onPartialUpdate(dc as Dc) as Void {
    }

}
