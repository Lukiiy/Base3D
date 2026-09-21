package src;

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


    public function extract(fov: Float, width: Float, height: Float): { x: Float, y: Float } {
        if (z <= 0.1) return null;

        var xProj = (x / z) * fov + (width / 2);
        var yProj = (-y / z) * fov + (height / 2);

        return { x: xProj, y: yProj };
    }
}