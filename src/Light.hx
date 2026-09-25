package src;

enum LightType {
    Ambient;
    Directional;
}

@:keep
class Light {
    public var type: LightType;
    public var direction: Vector3;
    public var intensity: Float;

    public function new(type: LightType, intensity: Float = 1) {
        this.type = type;
        this.intensity = intensity;
        this.direction = new Vector3(0, -1, 0);
    }

    public static function createAmbient(intensity: Float = .2): Light {
        return new Light(Ambient, intensity);
    }

    public static function createDirectional(dir: Vector3, intensity: Float = .8): Light {
        var light = new Light(Directional, intensity);

        light.direction = dir.normalize();

        return light;
    }
}