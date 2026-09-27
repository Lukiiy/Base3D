package src;

import src.Scene.RenderableFace;

@:keep
class Stroke implements PostModifier {
    public var color: String;
    public var thickness: Float;

    public function new(color: String = "#000000", thickness: Float = 1) {
        this.color = color;
        this.thickness = thickness;
    }

    public function apply(face: RenderableFace, renderer: Renderer): Void {
        for (i in 0...face.coords.length) { // TODO
            var p1 = face.coords[i];
            var p2 = face.coords[(i + 1) % face.coords.length];

            renderer.drawLine(p1.x, p1.y, p2.x, p2.y, color, thickness);
        }
    }
}