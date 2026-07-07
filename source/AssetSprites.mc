import Toybox.WatchUi;

class AssetSprites {
    private static var _modelOverlayActive = false;

    static function drawCentered(dc, resource, centerX, centerY) {
        try {
            var bitmap = WatchUi.loadResource(resource);
            if (bitmap != null) {
                dc.drawBitmap(
                    centerX - (bitmap.getWidth() / 2),
                    centerY - (bitmap.getHeight() / 2),
                    bitmap
                );
                return true;
            }
        } catch (ex) {
        }

        return false;
    }

    static function drawModelOverlay(dc, centerX, centerY) {
        _modelOverlayActive = drawCentered(
            dc,
            Rez.Drawables.ModelStaticOverlay,
            centerX,
            centerY
        );
        return _modelOverlayActive;
    }

    static function isModelOverlayActive() {
        return _modelOverlayActive;
    }
}
