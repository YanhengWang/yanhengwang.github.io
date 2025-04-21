// configure MathJax environment and macros
window.MathJax = {
    tex: {
        processEscapes: true,
        processEnvironments: false,
        macros: {
            Field: "\\mathbb{F}",
            Int: "\\mathbb{Z}",
            Nat: "\\mathbb{N}",
            Real: "\\mathbb{R}",
            Pr: "\\operatorname*{\\mathbb{P}}",
            Exp: "\\operatorname*{\\mathbb{E}}",
            T: "\\mathrm{T}",
            rank: "\\operatorname{rank}",
            set: ["\\left\\{ #1 \\right\\}", 1],
            class: ["\\mathcal{#1}", 1],
            card: ["\\lvert #1 \\rvert", 1],
            norm: ["\\lVert #1 \\rVert", 1],
            inner: ["\\left\\langle #1, \\thinspace #2 \\right\\rangle", 2]
        }
    }
};

// handle event for the sidebar
var expanded = true;
function toggle_sidebar(){
    if(expanded){
        document.getElementById("sidebar").style.left = "-95px";
        document.getElementById("paper").style.marginLeft = "15%";
    }else{
        document.getElementById("sidebar").style.left = "15px";
        document.getElementById("paper").style.marginLeft = "20%";
    }
    expanded = !expanded;
    return false;
}
