package src;

class ColorUtils {
    public static inline function getRed(c: Int): Int return (c >> 16) & 0xFF;
    public static inline function getGreen(c: Int): Int return (c >> 8) & 0xFF;
    public static inline function getBlue(c: Int): Int return c & 0xFF;
    
    public static inline function rgb(r: Int, g: Int, b: Int): Int {
        return (r << 16) | (g << 8) | b;
    }
    
    public static function lerp(start: Int, end: Int, t: Float): Int {
        var red = Std.int(getRed(start) + (getRed(end) - getRed(start)) * t);
        var green = Std.int(getGreen(start) + (getGreen(end) - getGreen(start)) * t);
        var blue = Std.int(getBlue(start) + (getBlue(end) - getBlue(start)) * t);
        
        return rgb(red, green, blue);
    }

    public static function getShade(c: Int, factor: Float): Int {
        if (factor >= 1.0) return c;
        
        var red = Std.int(getRed(c) * factor);
        var green = Std.int(getGreen(c) * factor);
        var blue = Std.int(getBlue(c) * factor);

        return (red << 16) | (green << 8) | blue;
    }
}