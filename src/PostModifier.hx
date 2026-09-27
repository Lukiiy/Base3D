package src;

import src.Scene.RenderableFace;

interface PostModifier {
    function apply(face: RenderableFace, renderer: Renderer): Void;
}
