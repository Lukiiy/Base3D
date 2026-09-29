package src;

interface IRenderer {
    function clear(hex: Int = 0x000000): Void;
    function drawLine(x: Float, y: Float, x2: Float, y2: Float, color: Int = 0xffffff, thickness: Float = 1): Void;
    function drawPolygon(points: Array<{x: Float, y: Float}>, fill: Int = 0xffffff): Void;
}