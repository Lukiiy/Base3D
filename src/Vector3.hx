package src;

@:keep
class Vector3 {
    public var x: Float;
    public var y: Float;
    public var z: Float;

    public function new(x: Float = 0, y: Float = 0, z: Float = 0) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    public function clone(): Vector3 return new Vector3(x, y, z);
    public function add(v: Vector3): Vector3 return new Vector3(x + v.x, y + v.y, z + v.z);
    public function sub(v: Vector3): Vector3 return new Vector3(x - v.x, y - v.y, z - v.z);
    public function scale(s: Float): Vector3 return new Vector3(x * s, y * s, z * s);

    public function rotateX(angleDeg: Float): Vector3 {
        var rad = angleDeg * (Math.PI / 180.0);
        var cos = Math.cos(rad);
        var sin = Math.sin(rad);

        return new Vector3(x, y * cos - z * sin, y * sin + z * cos);
    }

    public function rotateY(angleDeg: Float): Vector3 {
        var rad = angleDeg * (Math.PI / 180.0);
        var cos = Math.cos(rad);
        var sin = Math.sin(rad);

        return new Vector3(x * cos + z * sin, y, -x * sin + z * cos);
    }

    public function rotateZ(angleDeg: Float): Vector3 {
        var rad = angleDeg * (Math.PI / 180.0);
        var cos = Math.cos(rad);
        var sin = Math.sin(rad);

        return new Vector3(x * cos - y * sin, x * sin + y * cos, z);
    }

    public function dot(v: Vector3): Float {
        return x * v.x + y * v.y + z * v.z;
    }

    public function length(): Float {
        return Math.sqrt(x * x + y * y + z * z);
    }

    public function normalize(): Vector3 {
        var len = length();
        if (len == 0) return new Vector3(0, 0, 0);
        
        return new Vector3(x / len, y / len, z / len);
    }
}