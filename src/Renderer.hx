package src;

interface Renderer {
    function clear(hex: String = "#000000"): Void;
    function drawLine(x: Float, y: Float, x2: Float, y2: Float, color: String = "#FFFFFF", thickness: Float = 1.0): Void;
    function drawPolygon(points: Array<{x: Float, y: Float}>, fillColorHex: String, strokeColorHex: String = null): Void;
}