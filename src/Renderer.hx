package src;

class Renderer {
    private static inline var NEAR_PLANE: Float = 0.1;

    private var target: IRenderer;

    public function new(target: IRenderer) {
        this.target = target;
    }
}