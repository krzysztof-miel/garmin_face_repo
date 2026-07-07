import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.SensorHistory;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Weather;

class DataProvider {
    static const PLACEHOLDER = "--";

    static function getTimeLabel() {
        try {
            var clock = System.getClockTime();
            return clock.hour.format("%02d") + ":" + clock.min.format("%02d");
        } catch (ex) {
            return "--:--";
        }
    }

    static function getDateLabel() {
        try {
            var dateInfo = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
            return getPolishWeekday(dateInfo.day_of_week)
                + " "
                + dateInfo.day.toString();
        } catch (ex) {
            return PLACEHOLDER;
        }
    }

    static function getSteps() {
        try {
            var info = ActivityMonitor.getInfo();
            if (info != null && info.steps != null) {
                return info.steps.toString();
            }
        } catch (ex) {
        }
        return PLACEHOLDER;
    }

    static function getBatteryPercent() {
        try {
            var stats = System.getSystemStats();
            if (stats != null && stats.battery != null) {
                var value = stats.battery.toNumber();
                if (value < 0) {
                    return 0;
                }
                return value > 100 ? 100 : value;
            }
        } catch (ex) {
        }
        return null;
    }

    static function getTemperature() {
        try {
            var conditions = Weather.getCurrentConditions();
            if (conditions != null && conditions.temperature != null) {
                return conditions.temperature.toNumber().format("%d")
                    + "\u00b0C";
            }
        } catch (ex) {
        }
        return PLACEHOLDER + "\u00b0C";
    }

    static function getHeartRate() {
        try {
            var info = Activity.getActivityInfo();
            if (info != null && info.currentHeartRate != null) {
                return info.currentHeartRate.toString();
            }
        } catch (ex) {
        }
        return PLACEHOLDER;
    }

    static function getBodyBattery() {
        try {
            var iterator = SensorHistory.getBodyBatteryHistory({
                // Body Battery samples are sparse; null asks for the most
                // recent available history instead of only the last second.
                :period => null,
                :order => SensorHistory.ORDER_NEWEST_FIRST
            });
            if (iterator != null) {
                var sample = iterator.next();
                if (sample != null && sample.data != null) {
                    return sample.data.toNumber().format("%d");
                }
            }
        } catch (ex) {
        }
        return PLACEHOLDER;
    }

    private static function getPolishWeekday(dayOfWeek) {
        switch (dayOfWeek) {
            case Gregorian.DAY_MONDAY:
                return "PN";
            case Gregorian.DAY_TUESDAY:
                return "WT";
            case Gregorian.DAY_WEDNESDAY:
                return "\u015aR";
            case Gregorian.DAY_THURSDAY:
                return "CZW";
            case Gregorian.DAY_FRIDAY:
                return "PT";
            case Gregorian.DAY_SATURDAY:
                return "SOB";
            case Gregorian.DAY_SUNDAY:
                return "ND";
        }
        return PLACEHOLDER;
    }
}
